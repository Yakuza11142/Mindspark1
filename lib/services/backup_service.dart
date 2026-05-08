import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class BackupService {
  static Future<String> createBackup() async {
    final prefs = await SharedPreferences.getInstance();
    final allData = {};
    for (String key in prefs.getKeys()) {
      allData[key] = prefs.get(key);
    }
    return jsonEncode(allData);
  }
}