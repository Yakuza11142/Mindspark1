import 'package:shared_preferences/shared_preferences.dart';

class StudentBurnoutDetector {
  static Future<bool> shouldForceBreak() async {
    final prefs = await SharedPreferences.getInstance();
    int questionsAnsweredToday = prefs.getInt('q_answered_today') ?? 0;
    
    if (questionsAnsweredToday > 300) {
      print("🛑 BURNOUT PREVENTED: User answered 300 questions today. Forcing a screen break.");
      return true;
    }
    return false;
  }
}