import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConnectionMonitor {
  static Future<bool> isCloudReachable() async {
    try {
      // A lightweight ping to the database
      await Supabase.instance.client.from('profiles').select('id').limit(1);
      return true;
    } catch (e) {
      return false; // Network or Supabase is down
    }
  }
}