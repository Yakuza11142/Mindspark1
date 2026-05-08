import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final _client = Supabase.instance.client;

  // No hardcoding: uses the active session cable
  String? get uid => _client.auth.currentUser?.id;

  // SAVE USER DATA (The "Upsert" Master Key)
  Future<void> saveUserData(int sparks, int xp) async {
    if (uid == null) return;

    // 'upsert' works like Firebase's SetOptions(merge: true)
    await _client.from('users').upsert({
      'id': uid, // The primary key cable
      'sparks': sparks,
      'xp': xp,
      'last_active': DateTime.now().toIso8601String(),
    });
  }

  // GET USER DATA
  Future<Map<String, dynamic>?> getUserData() async {
    if (uid == null) return null;

    // Select the single row matching the user's foundation
    final data = await _client
        .from('users')
        .select()
        .eq('id', uid!)
        .maybeSingle(); // Returns null if not found instead of crashing
        
    return data;
  }
}
