import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:developer' as developer;

class VideoStorageManager {
  // Centralized configurations ensuring zero raw-string duplication across systems
  static const String _bucketName = 'generated_videos';
  static const String _videoExtension = '.mp4';
  static const String _contentTypeKey = 'video/mp4';

  /// Downloads a video endpoint payload into memory bytes and caches it securely inside Supabase Storage
  static Future<void> uploadToSupabaseBucket({
    required String videoUrl,
    required String targetFileName,
  }) async {
    final String sanitizedUrl = videoUrl.trim();
    final String sanitizedName = targetFileName.trim();

    if (sanitizedUrl.isEmpty || sanitizedName.isEmpty) {
      developer.log("⚠️ Storage Cancelled: Source video url or target name fields are empty.");
      return;
    }

    try {
      // 1. Download the raw video file bytes from the generation engine API link (Runway/HeyGen)
      final http.Response networkResponse = await http.get(Uri.parse(sanitizedUrl));
      
      if (networkResponse.statusCode != 200) {
        throw HttpException("Failed to download video stream. HTTP Status: ${networkResponse.statusCode}");
      }

      final Uint8List videoBytesBuffer = networkResponse.bodyBytes;

      // 2. Format a structured, unique path destination inside your storage ecosystem
      final String securePathDestination = '$sanitizedName$_videoExtension';

      // 3. Connect directly to your Supabase client storage channel to commit the payload bytes
      await Supabase.instance.client.storage
          .from(_bucketName)
          .uploadBytes(
            securePathDestination,
            videoBytesBuffer,
            fileOptions: const FileOptions(
              contentType: _contentTypeKey,
              upsert: true, // Overwrites existing matching data files to prevent duplicate error crashes
            ),
          );

      developer.log("💾 Storage Core: Generated video successfully cached up to Supabase bucket path: $securePathDestination");
    } catch (error, stackTrace) {
      // Enforces system isolation: Prevents backend errors from breaking app interface workflows
      developer.log(
        "🚨 Storage Core Failure: Error transferring external video asset down to database buckets.",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
