import 'package:shared_preferences/shared_preferences.dart';

class OfflineQueue {
  static Future<void> queueAction(String action) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> queue = prefs.getStringList('offline_queue') ?? [];
    queue.add(action);
    await prefs.setStringList('offline_queue', queue);
  }
}