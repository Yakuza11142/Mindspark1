import 'package:shared_preferences/shared_preferences.dart';

class ZenModeService {
  static Future<bool> isZenMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('zen_mode') ?? false;
  }

  static Future<void> toggleZen(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('zen_mode', value);
  }
}