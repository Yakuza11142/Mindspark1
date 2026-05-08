import 'package:shared_preferences/shared_preferences.dart';

class StreakShieldManager {
  static Future<void> earnShield() async {
    final prefs = await SharedPreferences.getInstance();
    // Logic: If 7 day streak, grant 1 free shield
    int streak = prefs.getInt('streak') ?? 0;
    if (streak % 7 == 0) {
      await prefs.setBool('has_shield', true);
    }
  }
}