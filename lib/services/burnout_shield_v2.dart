import 'package:shared_preferences/shared_preferences.dart';

class BurnoutShieldV2 {
  // Constants for the "Infinite" loop logic
  static const int maxWorkMinutes = 180; // 3 hours
  static const int restMinutes = 15;

  static Future<bool> shouldLockDevice() async {
    final prefs = await SharedPreferences.getInstance();
    int now = DateTime.now().millisecondsSinceEpoch;
    
    // 1. Get or set the initial start time
    int startTime = prefs.getInt('session_start_ms') ?? now;
    if (prefs.getInt('session_start_ms') == null) {
      await prefs.setInt('session_start_ms', startTime);
    }

    int durationMinutes = (now - startTime) ~/ 60000;

    // 2. Check if we have finished the 15-minute rest
    if (durationMinutes >= (maxWorkMinutes + restMinutes)) {
      await resetSession(); // RESET: This makes it infinite
      return false;
    }

    // 3. Check if we are currently in the 3-hour lockout window
    if (durationMinutes >= maxWorkMinutes) {
      print("🛑 BURNOUT SHIELD ACTIVE: Force rest for ${maxWorkMinutes + restMinutes - durationMinutes} more minutes.");
      return true;
    }

    return false;
  }

  static Future<void> resetSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('session_start_ms', DateTime.now().millisecondsSinceEpoch);
    print("♻️ SESSION RESET: New cycle started.");
  }
}
