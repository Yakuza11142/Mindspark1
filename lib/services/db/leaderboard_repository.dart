import 'package:supabase_flutter/supabase_flutter.dart';

class LeaderboardRepository {
  static final _supabase = Supabase.instance.client;

  static Future<List<Map<String, dynamic>>> getGlobalTop10() async {
    final response = await _supabase
        .from('profiles')
        .select('name, total_xp, is_pro')
        .order('total_xp', ascending: false)
        .limit(1000);
        
    return List<Map<String, dynamic>>.from(response);
  }
}