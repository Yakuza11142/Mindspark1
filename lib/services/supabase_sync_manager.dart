import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSyncManager {
  static final _supabase = Supabase.instance.client;

  static Future<void> backupUserData(int sparks, int xp) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return; // Only sync if logged in

    await _supabase.from('user_profiles').upsert({
      'id': user.id,
      'sparks': sparks,
      'xp': xp,
      'last_active': DateTime.now().toIso8601String(),
    });
    print("☁️ Data Secured to Supabase.");
  }
}