import 'package:shared_preferences/shared_preferences.dart';

class GoalSetter {
  static Future<void> setDailyGoal(int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('daily_goal', minutes);
  }
}