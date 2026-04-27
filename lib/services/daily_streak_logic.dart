import 'package:shared_preferences/shared_preferences.dart';

class StreakLogic {
  static Future<int> checkStreak() async {
    final prefs = await SharedPreferences.getInstance();
    String? lastDate = prefs.getString('last_login');
    int streak = prefs.getInt('streak') ?? 0;
    
    String today = DateTime.now().toString().split(' ')[0];
    
    if (lastDate == today) return streak; // Already logged in today
    
    if (lastDate != null) {
      DateTime last = DateTime.parse(lastDate);
      if (DateTime.now().difference(last).inDays == 1) {
        streak++; // Consecutive day
      } else {
        streak = 1; // Streak broken
      }
    } else {
      streak = 1; // First day
    }
    
    await prefs.setString('last_login', today);
    await prefs.setInt('streak', streak);
    return streak;
  }
}