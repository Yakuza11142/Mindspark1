import 'package:shared_preferences/shared_preferences.dart';

class AppStateRestorer {
  static Future<void> saveState(String screen, String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_screen', screen);
    await prefs.setString('last_data', data);
  }

  static Future<Map<String, String>?> restoreState() async {
    final prefs = await SharedPreferences.getInstance();
    String? screen = prefs.getString('last_screen');
    String? data = prefs.getString('last_data');
    if (screen != null && data != null) return {"screen": screen, "data": data};
    return null;
  }
}