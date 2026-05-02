import 'package:shared_preferences/shared_preferences.dart';

class StealthLogger {
  static Future<void> logThreat(String threatType) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> logs = prefs.getStringList('stealth_logs') ??[];
    logs.add("${DateTime.now().toIso8601String()} | THREAT: $threatType");
    await prefs.setStringList('stealth_logs', logs);
  }
}