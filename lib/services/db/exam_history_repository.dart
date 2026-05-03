import 'package:supabase_flutter/supabase_flutter.dart';

class ExamHistoryRepository {
  static final _supabase = Supabase.instance.client;

  static Future<void> saveExamResult(String examType, int score) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    await _supabase.from('exam_history').insert({
      'user_id': user.id,
      'exam_type': examType,
      'score': score,
      'taken_at': DateTime.now().toIso8601String(),
    });
  }
}