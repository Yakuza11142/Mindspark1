import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageUploader {
  static final _supabase = Supabase.instance.client;

  /// Uploads a local binary image file directly to the Supabase public assets storage bucket.
  /// Returns the public downloadable URL of the avatar image asset.
  static Future<String?> uploadAvatar(File imageFile) async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      debugPrint("⚠️ Upload Error: No authenticated user context found.");
      return null;
    }

    try {
      final String path = 'avatars/${user.id}.jpg';

      // Uploads raw binary file directly to your public assets storage bucket
      await _supabase.storage.from('public_assets').upload(
            path,
            imageFile,
            fileOptions: const FileOptions(
              contentType: 'image/jpeg',
              upsert: true,
            ),
          );

      // Retrieves the permanent index public endpoint routing destination link
      final String publicUrl = _supabase.storage.from('public_assets').getPublicUrl(path);
      return publicUrl;
      
    } catch (exception, stackTrace) {
      debugPrint("⚠️ Storage backend engine exception caught: $exception");
      debugPrint("$stackTrace");
      return null;
    }
  }
}
