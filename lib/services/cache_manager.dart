import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static Future<void> saveLesson(String topic, String content) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("cache_$topic", content);
  }

  static Future<String?> getLesson(String topic) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("cache_$topic");
  }
}