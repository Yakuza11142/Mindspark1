import 'package:shared_preferences/shared_preferences.dart';

class SunkCostManager {
  static Future<String> generateRetentionMessage() async {
    final prefs = await SharedPreferences.getInstance();
    int totalMinutes = prefs.getInt('total_study_minutes') ?? 0;
    int streak = prefs.getInt('streak') ?? 0;
    
    if (totalMinutes > 600) { // 10 hours
      return "You have invested ${totalMinutes ~/ 60} hours and built a $streak-day streak. Don't quit now. Your brain is rewiring itself.";
    }
    return "Consistency is the only cheat code.";
  }
}