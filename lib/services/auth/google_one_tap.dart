import 'package:supabase_flutter/supabase_flutter.dart';

class GoogleOneTap {
  static Future<void> signIn() async {
    // Requires google_sign_in package setup
    try {
      await Supabase.instance.client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'mindspark://login-callback',
      );
    } catch (e) {
      print("Google Sign-In failed.");
    }
  }
}