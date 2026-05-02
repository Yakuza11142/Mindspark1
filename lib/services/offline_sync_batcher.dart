import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OfflineSyncBatcher {
  static const String key = "offline_batch_queue";

  // 1. ADDS TO THE LOCAL QUEUE INSTEAD OF THE CLOUD
  static Future<void> queueRecord(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> queue = prefs.getStringList(key) ??[];
    queue.add(jsonEncode(data));
    await prefs.setStringList(key, queue);
    print("📦 Record added to offline batch queue. Total pending: ${queue.length}");
  }

  // 2. RUNS IN BACKGROUND WHEN NETWORK IS FREE (e.g., 2 AM)
  static Future<void> executeBatchUpload() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> queue = prefs.getStringList(key) ??[];
    if (queue.isEmpty) return;

    print("🚀 Initiating Batch Upload of ${queue.length} records to Supabase...");
    
    // Convert strings back to maps
    List<Map<String, dynamic>> payload = queue.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();

    try {
      // Supabase can insert a massive list of maps in a single network request
      await Supabase.instance.client.from('bulk_analytics_data').insert(payload);
      
      // If successful, wipe the local queue to free up phone storage
      await prefs.remove(key);
      print("✅ Batch Upload Successful. Phone storage cleared.");
    } catch (e) {
      print("❌ Batch Upload Failed. Will retry next cycle.");
    }
  }
}