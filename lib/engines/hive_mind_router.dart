import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'tripo_engine.dart';
import 'groq_api_service.dart';

class HiveMindRouter {
  static final _db = Supabase.instance.client;

  // Converts "Human Heart" into a unique code like "8f4a2b..."
  static String _generateHash(String prompt, String type) {
    var bytes = utf8.encode("$type-$prompt");
    return sha256.convert(bytes).toString();
  }

  // THE MASTER FETCH LOGIC
  static Future<String?> fetchAsset(String prompt, String type, bool forceNewMovement) async {
    String hash = _generateHash(prompt, type);

    // 1. IF NOT FORCING A NEW ONE, CHECK THE CLOUD CACHE FIRST
    if (!forceNewMovement) {
      print("🔍 Checking Global Hive Mind for: $prompt...");
      try {
        final cachedData = await _db.rpc('check_global_cache', params: {'p_hash': hash});
        if (cachedData != null) {
          print("✅ FOUND IN CACHE! Cost: $0.00. Latency: 0.1s");
          return cachedData as String;
        }
      } catch (e) {
        print("Cache miss. Generating new asset...");
      }
    } else {
      print("🔄 User requested New Movement. Bypassing cache...");
    }

    // 2. IF NOT IN CACHE (OR FORCED NEW), GENERATE FROM EXPENSIVE APIs
    String? newContent;
    if (type == '3D_MODEL') {
      newContent = await TripoEngine.generate3D(prompt);
    } else if (type == 'TEXT_LESSON') {
      newContent = await GroqApiService.askGroq(prompt, "llama3-70b-8192");
    }

    // 3. SAVE THE NEW CREATION TO THE CLOUD SO THE NEXT 10,000 USERS GET IT FREE
    if (newContent != null) {
      await _db.rpc('save_to_global_cache', params: {
        'p_hash': hash,
        'p_type': type,
        'p_content': newContent
      });
    }

    return newContent;
  }
}