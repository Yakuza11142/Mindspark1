import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/supabase_tables.dart';

class SupabaseSparksLedger {
  static final _supabase = Supabase.instance.client;

  static Future<void> secureAddSparks(int amount) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    // Uses a Postgres RPC (Remote Procedure Call) to add sparks safely
    await _supabase.rpc('add_sparks', params: {'user_id': user.id, 'amount': amount});
  }

  static Future<int> getCloudSparks() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return 0;

    final data = await _supabase.from(SupabaseTables.profiles).select('sparks').eq('id', user.id).single();
    return data['sparks'] as int;
  }
}