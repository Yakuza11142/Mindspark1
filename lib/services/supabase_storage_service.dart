import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  static Future<String?> uploadAvatar(String userId, File imageFile) async {
    try {
      final String path = 'avatars/$userId.jpg';
      await Supabase.instance.client.storage.from('mindspark_assets').upload(path, imageFile);
      return Supabase.instance.client.storage.from('mindspark_assets').getPublicUrl(path);
    } catch (e) {
      print("Storage Upload Error: $e");
      return null;
    }
  }
}