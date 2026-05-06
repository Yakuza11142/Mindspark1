import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalHistoryEngine {
  static const String key = "secure_exam_history";

  static Future<void> saveResult(String exam, int score) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(key) ??[];
    history.insert(0, jsonEncode({'exam': exam, 'score': score, 'date': DateTime.now().toIso8601String()}));
    if (history.length > 100) history.removeLast();
    await prefs.setStringList(key, history);
  }

  static Future<List<Map<String, dynamic>>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(key) ??[]).map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
  }
}