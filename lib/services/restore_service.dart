import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RestoreService {
  static Future<void> restoreBackup(String json) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> data = jsonDecode(json);
    data.forEach((key, value) async {
      if (value is int) await prefs.setInt(key, value);
      if (value is String) await prefs.setString(key, value);
      if (value is bool) await prefs.setBool(key, value);
    });
  }
}