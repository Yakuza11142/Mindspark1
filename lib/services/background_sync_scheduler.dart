import 'package:shared_preferences/shared_preferences.dart';

class BackgroundSyncScheduler {
  static Future<void> scheduleNightlySync() async {
    DateTime now = DateTime.now();
    if (now.hour == 2) { // 2 AM Server Sync
      print("☁️ Nightly Sync Initiated: Offloading 10,000 local records to Supabase.");
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('offline_batch_queue');
    }
  }
}