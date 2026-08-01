import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:developer' as developer;
import 'tripo_engine.dart';
import 'groq_api_service.dart';

class HiveMindRouter {
  static final _db = Supabase.instance.client;

  /// Converts an asset specification parameter set into a stable SHA-256 identifier string
  static String _generateHash(String prompt, String type) {
    final String standardizedInput = "$type-${prompt.trim().toLowerCase()}";
    final List<int> bytes = utf8.encode(standardizedInput);
    return sha256.convert(bytes).toString();
  }

  /// Extracts the target multi-modal asset from the global caching matrix or computes a fresh AI payload
  static Future<String?> fetchAsset(String prompt, String type, bool forceNewMovement) async {
    final String hash = _generateHash(prompt, type);
    final String cleanedPrompt = prompt.trim();

    // 1. GLOBAL CACHE INTERCEPTION TIMELINE
    if (!forceNewMovement) {
      developer.log("🔍 HiveMindRouter: Evaluating global cloud cache intercept for token hash: $hash");
      try {
        final dynamic cachedData = await _db.rpc(
          'check_global_cache', 
          params: {'p_hash': hash},
        ).timeout(
          const Duration(seconds: 5), 
        );

        if (cachedData != null) {
          if (cachedData is String && cachedData.isNotEmpty) {
            return cachedData;
          }
          if (cachedData is Map) {
            final Map<String, dynamic> structuredJson = Map<String, dynamic>.from(cachedData);
            if (structuredJson['content'] != null) {
              return structuredJson['content'].toString();
            }
          }
        }
      } catch (e, stack) {
        developer.log("⚠️ HiveMindRouter: Global cache resolution loop missed or aborted", error: e, stackTrace: stack);
      }
    } else {
      developer.log("🔄 HiveMindRouter: New Movement forced. Bypassing global cache layers.");
    }

    // 2. OUTBOUND COMPUTATIONAL EXPENDITURE PATHWAY
    String? newContent;
    try {
      // Corrected the variable reference identifiers to point to your declared 'cleanedPrompt' variable
      if (type == '3D_MODEL') {
        newContent = await TripoEngine.generate3D(cleanedPrompt);
      } else if (type == 'TEXT_LESSON') {
        newContent = await GroqApiService.askGroq(cleanedPrompt, "llama3-70b-8192");
      }
    } catch (e, stack) {
      developer.log("❌ HiveMindRouter: Core generation endpoint failure", error: e, stackTrace: stack);
      return null;
    }

    // 3. ASYNCHRONOUS BACK-PROPAGATION SAVING LOOP
    if (newContent != null && newContent.isNotEmpty) {
      // Offloaded network cache write backpropagation to execute concurrently, unblocking the main user thread instantly
      _db.rpc('save_to_global_cache', params: {
        'p_hash': hash,
        'p_type': type,
        'p_content': newContent.trim()
      }).catchError((Object error) {
        developer.log("❌ HiveMindRouter: Asynchronous cache backpropagation write task failed", error: error);
        return null;
      });
    }

    return newContent?.trim();
  }
}
