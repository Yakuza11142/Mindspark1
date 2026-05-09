import 'package:shared_preferences/shared_preferences.dart';

class AchievementService {
  static Future<void> checkMilestones(int totalSparks) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> unlocked = prefs.getStringList('achievements') ?? [];

    if (totalSparks >= 1000 && !unlocked.contains('spark_millionaire')) {
      unlocked.add('spark_millionaire');
      // Trigger Popup here
    }
    await prefs.setStringList('achievements', unlocked);
  }
}