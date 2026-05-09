import 'package:shared_preferences/shared_preferences.dart';

class OfflineSearchEngine {
  static Future<List<String>> searchHistory(String query) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('exam_history_log') ?? [];
    return history.where((e) => e.toLowerCase().contains(query.toLowerCase())).toList();
  }
}