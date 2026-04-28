import 'package:supabase_flutter/supabase_flutter.dart';

class ReportBadResponseService {
  static Future<void> flagResponse(String question, String badAnswer) async {
    try {
      await Supabase.instance.client.from('ai_feedback_logs').insert({
        'question': question,
        'ai_answer': badAnswer,
        'reported_at': DateTime.now().toIso8601String()
      });
      print("🚩 Bad response logged to Supabase for CEO review.");
    } catch (e) {
      print("Offline: Could not log feedback.");
    }
  }
}