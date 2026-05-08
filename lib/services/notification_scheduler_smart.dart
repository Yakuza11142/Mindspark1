import 'package:shared_preferences/shared_preferences.dart';

class SmartNotification {
  static void logStudyTime() async {
    final prefs = await SharedPreferences.getInstance();
    int hour = DateTime.now().hour;
    await prefs.setInt('preferred_study_hour', hour);
  }
  
  // Logic to schedule notification at 'preferred_study_hour'
}