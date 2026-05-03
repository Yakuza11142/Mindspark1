import 'package:shared_preferences/shared_preferences.dart';

class StreakFreezeAutoApply {
  static Future<void> checkAndApply() async {
    final prefs = await SharedPreferences.getInstance();
    bool hasFreeze = prefs.getBool('has_streak_freeze') ?? false;
    String? lastStudy = prefs.getString('last_study_date');
    
    if (hasFreeze && lastStudy != null) {
      if (DateTime.now().difference(DateTime.parse(lastLogin)).inDays == 2) {
        print("❄️ Streak Freeze Auto-Applied! User saved.");
        await prefs.setBool('has_streak_freeze', false);
        await prefs.setString('last_study_date', DateTime.now().subtract(const Duration(days: 1)).toIso8601String());
      }
    }
  }
}