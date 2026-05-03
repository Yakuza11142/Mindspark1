import 'package:shared_preferences/shared_preferences.dart';

class GuestModeBypass {
  static Future<bool> canPlayAsGuest() async {
    final prefs = await SharedPreferences.getInstance();
    int lessonsPlayed = prefs.getInt('guest_lessons') ?? 0;
    
    if (lessonsPlayed >= 3) return false; // Force Login
    
    await prefs.setInt('guest_lessons', lessonsPlayed + 1);
    return true;
  }
}