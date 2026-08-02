import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/user_profile_model.dart';

class UserRepository {
  final _supabase = Supabase.instance.client;

  /// Fetches the current user profile from the database
  Future<UserProfileModel?> getUserProfile() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return null;

      final data = await _supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();
          
      return UserProfileModel.fromJson(data);
    } on PostgrestException catch (databaseError) {
      // Catch and log explicit database structural or RLS violations
      print("❌ Database Fetch Failure [Code ${databaseError.code}]: ${databaseError.message}");
      print("Details: ${databaseError.details}");
      return null;
    } catch (e) {
      print("Unexpected system level error: $e");
      return null;
    }
  }

  /// Adjusts the user currency atomically on the backend database level.
  /// Pass a positive integer to credit rewards, or a negative integer to charge sparks.
  /// Returns [true] if the transaction passed, [false] if blocked or funds were insufficient.
  Future<bool> adjustSparksBalance(int alterationAmount) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return false;

      // Invoke the secure plpgsql script instead of pushing raw table writes
      final bool transactionPassed = await _supabase.rpc(
        'adjust_user_sparks',
        params: {'p_amount_change': alterationAmount},
      );

      return transactionPassed;
    } on PostgrestException catch (databaseError) {
      // Catches custom PL/pgSQL exceptions raised by your database function
      print("❌ RPC Ledger Failure [Code ${databaseError.code}]: ${databaseError.message}");
      return false;
    } catch (e) {
      print("Secure transaction validation request failed: $e");
      return false;
    }
  }
}
