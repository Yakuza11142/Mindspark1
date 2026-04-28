import 'package:shared_preferences/shared_preferences.dart';

class VulgarityStrikeLogger {
  static Future<int> logStrike() async {
    final prefs = await SharedPreferences.getInstance();
    int strikes = prefs.getInt('vulgarity_strikes') ?? 0;
    strikes++;
    await prefs.setInt('vulgarity_strikes', strikes);
    
    if (strikes >= 5) {
      print("⚠️ WARNING: User has triggered the shield 5 times. Threat level elevated.");
    }
    return strikes;
  }
}