import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/supabase_tables.dart';

class SupabaseExamVault {
  static Future<void> uploadScore(String examName, int score) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    await Supabase.instance.client.from(SupabaseTables.examHistory).insert({
      'user_id': user.id,
      'exam_name': examName,
      'score': score,
      'date': DateTime.now().toIso8601String()
    });
  }
}