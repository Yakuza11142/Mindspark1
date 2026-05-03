import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_core_config.dart';

class SupabaseAuthManager {
  static final _db = SupabaseCoreConfig.client;

  // 1. MAGIC LINK (For Teens & Adults)
  static Future<bool> sendMagicLink(String email) async {
    try {
      await _db.auth.signInWithOtp(
        email: email,
        emailRedirectTo: 'mindspark://auth-callback', // Deep link back to app
      );
      return true;
    } catch (e) {
      print("Auth Error: $e");
      return false;
    }
  }

  // 2. GHOST ACCOUNT (For Kids under 13 - No Email needed)
  static Future<bool> createGhostAccount() async {
    try {
      await _db.auth.signInAnonymously();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> logout() async {
    await _db.auth.signOut();
  }
  
  static User? get currentUser => _db.auth.currentUser;
}