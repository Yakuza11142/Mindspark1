import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class HistoryEngine {
  static const String KEY = "exam_history";

  static Future<void> saveResult({required String examType, required int score}) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(KEY) ?? [];
    Map<String, dynamic> entry = {
      'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'exam': examType,
      'score': score
    };
    history.insert(0, jsonEncode(entry));
    await prefs.setStringList(KEY, history);
  }

  static Future<List<Map<String, dynamic>>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> raw = prefs.getStringList(KEY) ?? [];
    return raw.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
  }
}