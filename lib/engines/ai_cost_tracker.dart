import 'package:supabase_flutter/supabase_flutter.dart';

class AiCostTracker {
  static Future<void> logApiCall(String modelUsed, int tokensEstimated) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    await Supabase.instance.client.rpc('increment_api_usage', params: {
      'p_user_id': user.id,
      'p_model': modelUsed,
      'p_tokens': tokensEstimated
    });
  }
}