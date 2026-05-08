import 'package:shared_preferences/shared_preferences.dart';

class HapticSettings {
  static Future<bool> isEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('haptics') ?? true;
  }
}