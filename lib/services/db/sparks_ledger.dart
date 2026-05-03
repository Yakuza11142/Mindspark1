import 'package:supabase_flutter/supabase_flutter.dart';

class SparksLedger {
  static final _supabase = Supabase.instance.client;

  static Future<bool> recordTransaction(String type, int amount) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return false;

    try {
      // Calls a secure Postgres function in Supabase to prevent race conditions
      await _supabase.rpc('process_spark_transaction', params: {
        'p_user_id': user.id,
        'p_amount': amount,
        'p_type': type // e.g., 'ad_watched', 'bought_xray'
      });
      return true;
    } catch (e) {
      print("Transaction failed: $e");
      return false;
    }
  }
}