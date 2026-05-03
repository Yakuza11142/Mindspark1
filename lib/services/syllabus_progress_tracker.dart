import 'package:supabase_flutter/supabase_flutter.dart';

class SyllabusProgressTracker {
  static Future<void> updateMastery(String hwId, String subject, String topic, int score) async {
    await Supabase.instance.client.rpc('update_topic_mastery', params: {
      'p_hw_id': hwId, 'p_sub': subject, 'p_top': topic, 'p_score': score
    });
  }
}