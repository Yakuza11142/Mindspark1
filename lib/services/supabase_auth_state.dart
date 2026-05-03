import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthState {
  static void listen() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        print("User Signed In to Supabase");
      } else if (event == AuthChangeEvent.signedOut) {
        print("User Signed Out");
      }
    });
  }
}