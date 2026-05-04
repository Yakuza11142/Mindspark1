import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';

class SupabaseOfflineQueue {
  static Future<void> queueData(String table, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> queue = prefs.getStringList('supa_queue') ??[];
    queue.add(jsonEncode({'table': table, 'data': data}));
    await prefs.setStringList('supa_queue', queue);
  }

  static Future<void> syncQueue() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> queue = prefs.getStringList('supa_queue') ??[];
    if (queue.isEmpty) return;

    final client = Supabase.instance.client;
    List<String> remaining =[];

    for (String item in queue) {
      var map = jsonDecode(item);
      try {
        await client.from(map['table']).insert(map['data']);
      } catch (e) {
        remaining.add(item); // Keep if failed
      }
    }
    await prefs.setStringList('supa_queue', remaining);
  }
}