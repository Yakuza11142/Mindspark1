import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static Future<bool> isExpired(String key) async {
    final prefs = await SharedPreferences.getInstance();
    int? timestamp = prefs.getInt('${key}_time');
    if (timestamp == null) return true;
    
    int now = DateTime.now().millisecondsSinceEpoch;
    return (now - timestamp) > 604800000; // 7 Days
  }
}