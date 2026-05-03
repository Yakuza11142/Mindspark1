import 'package:supabase_flutter/supabase_flutter.dart';

class AccountUpgrader {
  static final _supabase = Supabase.instance.client;

  static Future<bool> linkEmailToGhostAccount(String email) async {
    try {
      // Sends an OTP to link the anonymous account to an email
      await _supabase.auth.updateUser(UserAttributes(email: email));
      await _supabase.from('profiles').update({'is_child_account': false}).eq('id', _supabase.auth.currentUser!.id);
      return true;
    } catch (e) {
      return false;
    }
  }
}