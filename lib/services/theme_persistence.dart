import 'package:shared_preferences/shared_preferences.dart';

class ThemePersistence {
  static Future<void> saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_dark', isDark);
  }
}