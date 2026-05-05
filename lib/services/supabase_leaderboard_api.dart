import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseLeaderboardApi {
  static Future<List<Map<String, dynamic>>> getTopStudents() async {
    try {
      final data = await Supabase.instance.client
          .from('user_profiles')
          .select('name, xp, country')
          .order('xp', ascending: false)
          .limit(1000);
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      return[]; // Fallback to local simulated leaderboard if offline
    }
  }
}