import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseMetricPusher {
  static Future<void> pushHabitData(String habitProfile, double avgRetention) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    await Supabase.instance.client.from('user_analytics').upsert({
      'user_id': user.id,
      'study_persona': habitProfile,
      'memory_retention_score': avgRetention,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }
}