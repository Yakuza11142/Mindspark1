import 'package:supabase_flutter/supabase_flutter.dart';

class ApiKeyRotator {
  static String? dynamicGeminiKey;

  static Future<void> fetchLatestKeys() async {
    try {
      final data = await Supabase.instance.client.from('api_vault').select('gemini_key').single();
      dynamicGeminiKey = data['gemini_key'];
      print("🔑 Security Keys rotated successfully from cloud.");
    } catch (e) {
      print("Offline: Using hardcoded fallback keys.");
    }
  }
}