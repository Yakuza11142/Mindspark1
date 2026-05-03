import 'package:shared_preferences/shared_preferences.dart';

class ApiRateLimiter {
  static const int MAX_FREE_CALLS = 10; // 10 questions per day for free users

  static Future<bool> canMakeRequest(bool isPro) async {
    if (isPro) return true; // Unlimited for paying users

    final prefs = await SharedPreferences.getInstance();
    String today = DateTime.now().toString().split(' ')[0];
    String lastDate = prefs.getString('api_date') ?? "";
    int calls = prefs.getInt('api_calls') ?? 0;

    if (today != lastDate) {
      await prefs.setString('api_date', today);
      await prefs.setInt('api_calls', 1);
      return true;
    }

    if (calls < MAX_FREE_CALLS) {
      await prefs.setInt('api_calls', calls + 1);
      return true;
    }
    return false; // Force them to buy Pro or watch an ad
  }
}