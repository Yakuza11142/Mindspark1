import 'package:shared_preferences/shared_preferences.dart';

class AiRateLimiter {
  static Future<bool> canRequest() async {
    final prefs = await SharedPreferences.getInstance();
    int count = prefs.getInt('daily_requests') ?? 0;
    if (count > 50) return false; // Max 50 AI calls per day for free users
    await prefs.setInt('daily_requests', count + 1);
    return true;
  }
}