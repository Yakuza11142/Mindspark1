import '../config/supabase_core_config.dart';

class SupabaseSparksBank {
  static final _db = SupabaseCoreConfig.client;

  // Uses Postgres RPC (Remote Procedure Call) so the calculation happens on Google's server, not the phone.
  static Future<bool> addSparksSecurely(int amount) async {
    try {
      await _db.rpc('increment_sparks', params: {'amount': amount});
      return true;
    } catch (e) {
      print("Transaction failed. Hacker detected or Network drop.");
      return false;
    }
  }

  static Future<int> getBalance() async {
    final user = _db.auth.currentUser;
    if (user == null) return 0;
    
    final data = await _db.from('profiles').select('sparks').eq('id', user.id).single();
    return data['sparks'] as int;
  }
}