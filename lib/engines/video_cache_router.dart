import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VideoCacheRouter {
  // Central source of truth for the Supabase cache tracking table
  static const String _cacheTable = 'video_generation_cache';
  static const String _storageBucket = 'hologram_videos';

  /// Fetches a verified video path or signed cloud URL.
  /// Evaluates local storage disk first, falls back to metadata database second.
  static Future<String?> getSavedVideo(String questionHash) async {
    if (questionHash.trim().isEmpty) return null;

    final String cleanHash = questionHash.trim().toLowerCase();
    final String expectedFileName = '$cleanHash.mp4';

    try {
      // LAYER 1: Local Device Disk Check (0ms Latency Target)
      // Check if the video file was already downloaded and cached locally on this phone
      final FileInfo? localCacheFile = await DefaultCacheManager().getFileFromCache(expectedFileName);
      
      if (localCacheFile != null && await localCacheFile.file.exists()) {
        debugPrint("💾 [Cache Hit] Serving video straight from local mobile disk: $expectedFileName");
        return localCacheFile.file.path; // Returns local path instantly (e.g., /data/user/0/...)
      }

      // LAYER 2: Cloud Database Metadata Index Check (<15ms Target)
      // Query an indexed metadata table instead of running a heavy, slow storage bucket list request
      final supabase = Supabase.instance.client;
      final List<Map<String, dynamic>> databaseResult = await supabase
          .from(_cacheTable)
          .select('storage_path, is_ready')
          .eq('question_hash', cleanHash)
          .limit(1);

      if (databaseResult.isEmpty) {
        debugPrint("❄️ [Cache Miss] No previous generation entry found for hash: $cleanHash");
        return null; // Must generate live
      }

      final Map<String, dynamic> cacheRecord = databaseResult.first;
      final bool isReady = cacheRecord['is_ready'] ?? false;
      final String? cloudStoragePath = cacheRecord['storage_path'];

      if (!isReady || cloudStoragePath == null) {
        debugPrint("⏳ [Cache Pending] Video is currently compiling in the cloud pipeline.");
        return null;
      }

      // LAYER 3: Generate Signed URL and Queue Background Download
      // Generate a secure streaming URL that expires safely after 1 hour
      final String signedUrl = await supabase.storage
          .from(_storageBucket)
          .createSignedUrl(cloudStoragePath, 3600);

      // Proactively stream the file down to the local cache disk in the background 
      // so it is instantly available offline on the next request
      unawaited(
        DefaultCacheManager().downloadFile(signedUrl, key: expectedFileName).catchError((error) {
          debugPrint("⚠️ Background video cache download skipped: ${error.toString()}");
          return FileInfo(File(''), FileSource.online, DateTime.now(), signedUrl);
        }),
      );

      debugPrint("🛰️ [Cloud Cache Hit] Serving signed streaming vector URL from metadata index.");
      return signedUrl;

    } catch (e) {
      debugPrint("🚨 VideoCacheRouter Intercept Failure: ${e.toString()}");
      return null; // Graceful fallback: build live if cache checks encounter errors
    }
  }

  /// Registers a newly generated video into the cloud metadata index database table
  static Future<void> registerNewVideoEntry(String questionHash, String storagePath) async {
    try {
      final supabase = Supabase.instance.client;
      await supabase.from(_cacheTable).upsert({
        'question_hash': questionHash.trim().toLowerCase(),
        'storage_path': storagePath,
        'is_ready': true,
        'created_at': DateTime.now().toUtc().toIso8601String(),
      });
      debugPrint("🎯 New video generation signature indexed securely in metadata database.");
    } catch (e) {
      debugPrint("🚨 Failed to write video metadata index: ${e.toString()}");
    }
  }
}
