import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthProvider {
  final _supabase = Supabase.instance.client;

  Future<AuthResponse> signUp(String email, String password, String name) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': name},
    );
    
    // Create initial user profile in the database
    if (response.user != null) {
      await _supabase.from('profiles').insert({
        'id': response.user!.id,
        'email': email,
        'name': name,
        'sparks': 100, // Starting bonus
        'total_xp': 0,
        'is_pro': false,
      });
    }
    return response;
  }

  Future<AuthResponse> signIn(String email, String password) async {
    return await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}