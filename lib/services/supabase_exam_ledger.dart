import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Assumptions based on your setup imports:
// These classes must be defined in your app core or configuration scopes.
abstract class SupabaseCoreConfig {
  static final SupabaseClient client = Supabase.instance.client;
}
abstract class SupabaseOfflineMutations {
  static void queueWrite(String table, Map<String, dynamic> data) {}
}

class SupabaseExamLedger {
  SupabaseExamLedger._internal();
  static final SupabaseExamLedger instance = SupabaseExamLedger._internal();

  Future<void> uploadScore({required String examType, required int score}) async {
    final user = SupabaseCoreConfig.client.auth.currentUser;
    if (user == null) return;

    final payload = {
      'user_id': user.id,
      'exam_type': examType,
      'score': score,
      'created_at': DateTime.now().toIso8601String(),
    };

    try {
      // Process through the Edge Function
      final response = await SupabaseCoreConfig.client.functions.invoke(
        'upload-score',
        body: payload,
      );

      if (response.status != 200) {
        throw Exception("Edge Function failed: ${response.data}");
      }
    } catch (e) {
      // If Edge call fails, fallback to your offline queue
      debugPrint("Edge Processing failed, queuing offline: $e");
      SupabaseOfflineMutations.queueWrite('exam_results', payload);
    }
  }
}
