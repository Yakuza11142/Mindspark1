import 'package:shared_preferences/shared_preferences.dart';

class CrashRecoveryManager {
  static Future<void> saveProgressSnapshot(String topic, int questionIndex, int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('crash_snapshot', "$topic|$questionIndex|$score");
  }

  static Future<Map<String, dynamic>?> recoverSnapshot() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('crash_snapshot');
    if (data == null) return null;
    
    List<String> parts = data.split('|');
    return {
      'topic': parts[0],
      'index': int.parse(parts[1]),
      'score': int.parse(parts[2])
    };
  }
  
  static Future<void> clearSnapshot() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('crash_snapshot');
  }
}