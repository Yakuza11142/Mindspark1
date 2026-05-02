import 'package:shared_preferences/shared_preferences.dart';

class SystemModeController {
  static const String key = "app_mode";
  
  static Future<String> getMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "EXPLORE"; // 'EXPLORE' or 'EXAM'
  }

  static Future<void> setMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, mode);
  }
}