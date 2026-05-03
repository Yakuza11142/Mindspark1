import 'package:supabase_flutter/supabase_flutter.dart';

class AnonymousKidAuth {
  static final _supabase = Supabase.instance.client;

  static Future<bool> signInGhost() async {
    try {
      // Supabase Anonymous Sign-In
      final AuthResponse res = await _supabase.auth.signInAnonymously();
      if (res.user != null) {
        // Initialize an empty profile for the kid in the cloud
        await _supabase.from('profiles').upsert({
          'id': res.user!.id,
          'is_child_account': true,
          'sparks': 100,
        });
        print("👶 Ghost Account Created. COPPA Safe.");
        return true;
      }
      return false;
    } catch (e) {
      print("Ghost Auth Failed: $e");
      return false;
    }
  }
}