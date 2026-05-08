import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LibraryManager {
  static Future<void> saveItem(String title, String type) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> library = prefs.getStringList('my_library') ?? [];
    
    Map<String, dynamic> item = {
      'title': title,
      'type': type,
      'date': DateTime.now().toIso8601String()
    };
    
    library.add(jsonEncode(item));
    await prefs.setStringList('my_library', library);
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> library = prefs.getStringList('my_library') ?? [];
    return library.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
  }
}