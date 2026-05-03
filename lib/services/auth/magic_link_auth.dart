import 'package:supabase_flutter/supabase_flutter.dart';

class MagicLinkAuth {
  static final _supabase = Supabase.instance.client;

  static Future<bool> sendLink(String email) async {
    try {
      await _supabase.auth.signInWithOtp(
        email: email,
        emailRedirectTo: 'mindspark://login-callback', // Android Deep Link
      );
      print("✨ Magic Link dispatched to $email");
      return true;
    } catch (e) {
      print("Supabase OTP Error: $e");
      return false;
    }
  }
}
import 'package:supabase_flutter/supabase_flutter.dart';

class MagicLinkAuth {
  static final _supabase = Supabase.instance.client;

  static Future<bool> sendMagicLink(String email) async {
    try {
      await _supabase.auth.signInWithOtp(
        email: email,
        emailRedirectTo: 'mindspark://login-callback', // Deep link back to app
      );
      print("✨ Magic Link sent to $email");
      return true;
    } catch (e) {
      print("Magic Link Error: $e");
      return false;
    }
  }
}