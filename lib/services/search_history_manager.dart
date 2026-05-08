import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryManager {
  static const KEY = "search_history_list";

  static Future<void> addSearch(String query) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList(KEY) ?? [];
    if (!list.contains(query)) {
      list.insert(0, query);
      if (list.length > 10) list.removeLast();
      await prefs.setStringList(KEY, list);
    }
  }

  static Future<List<String>> getRecent() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(KEY) ?? [];
  }
}