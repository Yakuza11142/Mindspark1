import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSparksLedger {
  static final _supabase = Supabase.instance.client;

  /// Claims spark rewards safely by declaring what event took place.
  /// This prevents users from injecting forged integer amounts into your economy.
  static Future<bool> claimRewardForEvent(String eventKey) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return false;

      // Send the strict string tracking code to your secure plpgsql script
      await _supabase.rpc(
        'add_sparks_by_event', 
        params: {'p_event_key': eventKey},
      );
      
      print("🎉 Reward balance modification applied successfully for event: $eventKey");
      return true;
    } catch (e) {
      print("Secure ledger mutation rejected: $e");
      return false;
    }
  }

  /// Fetches the user's active cloud balance payload
  static Future<int> getCloudSparks() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return 0;

      final data = await _supabase
          .from('profiles')
          .select('sparks')
          .eq('id', user.id)
          .single();
          
      return data['sparks'] as int;
    } catch (e) {
      print("Failed to sync current balance fields: $e");
      return 0;
    }
  }
}
