import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthProvider {
  final _supabase = Supabase.instance.client;

  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;
  User? get currentUser => _supabase.auth.currentUser;
  Session? get currentSession => _supabase.auth.currentSession;

  /// Exposes a realtime stream of the currently logged-in user's profile database row.
  /// Emits a Map containing live keys like 'sparks', 'total_xp', and 'name'.
  Stream<Map<String, dynamic>?> get profileStream {
    final userId = currentUser?.id;
    if (userId == null) {
      return Stream.value(null);
    }
    
    // Listens in realtime exclusively to modifications on this specific user profile row
    return _supabase
        .from('profiles')
        .stream(primaryKey: ['id'])
        .eq('id', userId)
        .map((data) => data.isNotEmpty ? data.first : null);
  }

  Future<AuthResponse> signUp({
    required String email, 
    required String password, 
    required String name,
  }) async {
    try {
      return await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': name},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthResponse> signIn({
    required String email, 
    required String password,
  }) async {
    try {
      return await _supabase.auth.signInWithPassword(
        email: email, 
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
