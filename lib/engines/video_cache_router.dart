import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:developer' as developer;

class VideoCacheRouter {
  static const String _cacheTable = 'video_generation_cache';
  static const String _storageBucket = 'hologram_videos';

  /// Fetches a verified video path or signed cloud URL.
  /// Evaluates local storage disk first, falls back to metadata database second.
  static Future<String?> getSavedVideo(String questionHash) async {
    final String cleanHash = questionHash.trim().toLowerCase();
    if (cleanHash.isEmpty) return null;

    final String expectedFileName = '$cleanHash.mp4';

    try {
      // LAYER 1: Local Device Disk Check (0ms Latency Target)
      final FileInfo? localCacheFile = await DefaultCacheManager().getFileFromCache(expectedFileName);

      if (localCacheFile != null && await localCacheFile.file.exists()) {
        developer.log("💾 VideoCacheRouter: [Cache Hit] Serving video straight from local mobile disk: $expectedFileName");
        return localCacheFile.file.path; 
      }

      // LAYER 2: Cloud Database Metadata Index Check (<15ms Target)
      final SupabaseClient supabase = Supabase.instance.client;

      final dynamic databaseResult = await supabase
          .from(_cacheTable)
          .select('storage_path, is_ready')
          .eq('question_hash', cleanHash)
          .limit(1)
          .timeout(const Duration(seconds: 5)); 

      if (databaseResult == null || databaseResult is! List || databaseResult.isEmpty) {
        developer.log("❄️ VideoCacheRouter: [Cache Miss] No previous generation entry found for hash: $cleanHash");
        return null; 
      }

      final Map<String, dynamic> cacheRecord = Map<String, dynamic>.from(databaseResult.first as Map);
      final bool isReady = cacheRecord['is_ready'] ?? false;
      final String? cloudStoragePath = cacheRecord['storage_path'] as String?;

      if (!isReady || cloudStoragePath == null || cloudStoragePath.isEmpty) {
        developer.log("⏳ VideoCacheRouter: [Cache Pending] Video is currently compiling in the cloud pipeline.");
        return null;
      }

      // LAYER 3: Generate Signed URL and Queue Background Download
      final String signedUrl = await supabase.storage
          .from(_storageBucket)
          .createSignedUrl(cloudStoragePath, 3600);

      _downloadAndCacheBackground(signedUrl, expectedFileName);

      developer.log("🛰️ VideoCacheRouter: [Cloud Cache Hit] Serving signed streaming vector URL from metadata index.");
      return signedUrl;

    } catch (e, stackTrace) {
      developer.log("❌ VideoCacheRouter: Intercept pipeline encountered an unexpected exception", error: e, stackTrace: stackTrace);
      return null; 
    }
  }

  /// Registers a newly generated video into the cloud metadata index database table
  static Future<void> registerNewVideoEntry(String questionHash, String storagePath) async {
    final String cleanHash = questionHash.trim().toLowerCase();
    final String cleanPath = storagePath.trim();

    if (cleanHash.isEmpty || cleanPath.isEmpty) return;

    try {
      final SupabaseClient supabase = Supabase.instance.client;
      await supabase.from(_cacheTable).upsert({
        'question_hash': cleanHash,
        'storage_path': cleanPath,
        'is_ready': true,
        'created_at': DateTime.now().toUtc().toIso8601String(),
      });
      developer.log("🎯 VideoCacheRouter: New video generation signature indexed securely in metadata database.");
    } catch (e, stackTrace) {
      developer.log("❌ VideoCacheRouter: Failed to write video metadata index mapping", error: e, stackTrace: stackTrace);
    }
  }

  /// Safely dispatches un-awaited media fetching streams down background isolates cleanly
  static void _downloadAndCacheBackground(String signedUrl, String cacheKey) {
    DefaultCacheManager().downloadFile(signedUrl, key: cacheKey).then((FileInfo fileInfo) {
      developer.log("✅ VideoCacheRouter: Background cache download finalized successfully for asset key: $cacheKey");
    }).catchError((Object error) {
      // FIXED: Adjusted the asynchronous return signature contract to bypass stream typing failures safely
      developer.log("⚠️ VideoCacheRouter: Background video asset cache pre-fetch skipped gracefully: $error");
      return Future<FileInfo?>.value(null); 
    });
  }
}
