import '../../config/supabase_core_config.dart';

class LeaderboardRepository {
  static Future<List<Map<String, dynamic>>> getGlobalTop10() async {
    try {
      await SupabaseCoreConfig.initialize();
      
      final response = await SupabaseCoreConfig.client
          .from('profiles')
          .select('id, username, total_xp, is_pro')
          .order('total_xp', ascending: false)
          .limit(10);

      // Ensure response is a List<Map<String, dynamic>>
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print("❌ Error fetching leaderboard: $e");
      return [];
    }
  }

  static Future<Map<String, dynamic>?> getUserRank(String userId) async {
    try {
      await SupabaseCoreConfig.initialize();
      
      final response = await SupabaseCoreConfig.client
          .from('profiles')
          .select('*')
          .eq('id', userId)
          .single();

      return response;
    } catch (e) {
      print("❌ Error fetching user rank: $e");
      return null;
    }
  }
}
