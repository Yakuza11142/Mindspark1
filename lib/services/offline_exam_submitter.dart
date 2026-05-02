import 'package:shared_preferences/shared_preferences.dart';

class OfflineExamSubmitter {
  static Future<void> queueResult(String examId, int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('pending_exam_$examId', score);
    print("📦 Exam Result Queued Offline. Safe.");
  }
}