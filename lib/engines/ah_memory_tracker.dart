import 'package:shared_preferences/shared_preferences.dart';

class AhMemoryTracker {
  static Future<void> logVulgarityStrike() async {
    final prefs = await SharedPreferences.getInstance();
    int strikes = prefs.getInt('ah_vulgarity_strikes') ?? 0;
    await prefs.setInt('ah_vulgarity_strikes', strikes + 1);
  }

  static Future<String> getMorningGreeting(String ahName) async {
    final prefs = await SharedPreferences.getInstance();
    int strikes = prefs.getInt('ah_vulgarity_strikes') ?? 0;

    if (strikes > 2 && ahName == "Nexus") {
      return "Let us hope your attitude today is better than yesterday. Let's begin the physics module.";
    }
    return "Welcome back. Let's achieve greatness today.";
  }
}
import 'package:shared_preferences/shared_preferences.dart';

class AhMemoryTracker {
  static Future<void> logVulgarityStrike() async {
    final prefs = await SharedPreferences.getInstance();
    int strikes = prefs.getInt('ah_vulgarity_strikes') ?? 0;
    await prefs.setInt('ah_vulgarity_strikes', strikes + 1);
  }

  static Future<String> getMorningGreeting(String ahName) async {
    final prefs = await SharedPreferences.getInstance();
    int strikes = prefs.getInt('ah_vulgarity_strikes') ?? 0;

    if (strikes > 2 && ahName == "Nexus") {
      return "Let us hope your attitude today is better than yesterday. Let's begin the physics module.";
    }
    return "Welcome back. Let's achieve greatness today.";
  }
}