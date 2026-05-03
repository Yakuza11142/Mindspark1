import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/supabase_core_config.dart';

class SupabaseOfflineMutations {
  static const String key = "supa_offline_queue";

  static Future<void> queueWrite(String table, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> queue = prefs.getStringList(key) ??[];
    queue.add(jsonEncode({'table': table, 'data': data}));
    await prefs.setStringList(key, queue);
    print("📦 Saved to Offline Cloud Queue.");
  }

  static Future<void> syncQueue() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> queue = prefs.getStringList(key) ??[];
    if (queue.isEmpty) return;

    List<String> remaining =[];
    for (String item in queue) {
      var map = jsonDecode(item);
      try {
        await SupabaseCoreConfig.client.from(map['table']).insert(map['data']);
      } catch (e) {
        remaining.add(item); // Keep it if it fails again
      }
    }
    await prefs.setStringList(key, remaining);
    print("🌍 Offline Queue Synced to Supabase.");
  }
}