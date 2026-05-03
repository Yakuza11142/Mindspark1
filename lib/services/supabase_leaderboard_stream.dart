import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_core_config.dart';

class SupabaseLeaderboardStream {
  static Stream<List<Map<String, dynamic>>> getLiveTop50() {
    return SupabaseCoreConfig.client
        .from('profiles')
        .stream(primaryKey: ['id'])
        .order('xp', ascending: false)
        .limit(50);
  }
}