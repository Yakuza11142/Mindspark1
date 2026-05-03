import '../config/supabase_core_config.dart';
import 'supabase_offline_mutations.dart';

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
      print("Edge Processing failed, queuing offline: $e");
      SupabaseOfflineMutations.queueWrite('exam_results', payload);
    }
  }
}
// supabase/functions/upload-score/index.ts
import { createClient } from 'jsr:@supabase/supabase-js@2'

Deno.serve(async (req) => {
  try {
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    // Parse the JSON payload from the Flutter client
    const { exam_type, score, user_id, created_at } = await req.json()

    const { error } = await supabase
      .from('exam_results')
      .insert({ 
        user_id, 
        exam_type, 
        score, 
        created_at: created_at ?? new Date().toISOString() 
      })

    if (error) throw error

    return new Response(JSON.stringify({ success: true }), { 
      headers: { "Content-Type": "application/json" } 
    })
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 400 })
  }
})
