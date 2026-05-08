import 'package:shared_preferences/shared_preferences.dart';

class BookmarkService {
  static Future<void> save(String topic) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList('bookmarks') ?? [];
    if (!list.contains(topic)) list.add(topic);
    await prefs.setStringList('bookmarks', list);
  }

  static Future<List<String>> get() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('bookmarks') ?? [];
  }
}