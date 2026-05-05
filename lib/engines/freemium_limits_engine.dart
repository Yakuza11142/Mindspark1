import 'package:shared_preferences/shared_preferences.dart';

class FreemiumLimitsEngine {
  static const int DAILY_FREE_LIMIT = 15; // Only 15 free questions a day

  static Future<bool> canAskQuestion(bool isPro) async {
    if (isPro) return true; // Pro users have no limits

    final prefs = await SharedPreferences.getInstance();
    String today = DateTime.now().toString().split(' ')[0];
    String lastDate = prefs.getString('limit_date') ?? "";
    int count = prefs.getInt('free_question_count') ?? 0;

    if (lastDate != today) {
      await prefs.setString('limit_date', today);
      await prefs.setInt('free_question_count', 1);
      return true;
    }

    if (count < DAILY_FREE_LIMIT) {
      await prefs.setInt('free_question_count', count + 1);
      return true;
    }
    
    return false; // Limit Reached
  }
}