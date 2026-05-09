import 'package:shared_preferences/shared_preferences.dart';

class BadgeManager {
  static Future<List<String>> checkUnlock(int streak, int score) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> badges = prefs.getStringList('badges') ?? [];
    List<String> newUnlocks = [];

    if (streak >= 7 && !badges.contains('week_warrior')) {
      badges.add('week_warrior');
      newUnlocks.add("Week Warrior 🛡️");
    }
    if (score == 100 && !badges.contains('perfectionist')) {
      badges.add('perfectionist');
      newUnlocks.add("Perfectionist 💎");
    }

    await prefs.setStringList('badges', badges);
    return newUnlocks;
  }
}