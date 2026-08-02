import 'package:supabase_flutter/supabase_flutter.dart';

class AccountUpgrader {
  static final _supabase = Supabase.instance.client;

  static Future<bool> linkEmailToGhostAccount({
    required String email, 
    required String password,
  }) async {
    try {
      // 1. Upgrade the anonymous user record in Supabase Auth system
      final AuthResponse response = await _supabase.auth.updateUser(
        UserAttributes(
          email: email,
          password: password,
        ),
      );
      
      final updatedUser = response.user;
      if (updatedUser == null) return false;

      // 2. Check if a confirmation email was actually sent out.
      // If "Confirm Email" is ON in Supabase, the user will have an unconfirmed email metadata field.
      // If "Confirm Email" is OFF, the email changes immediately and 'unconfirmed_email' will be null.
      final bool requiresConfirmation = updatedUser.unconfirmedEmail != null || 
                                        updatedUser.newEmail != null;

      // 3. Update the database immediately ONLY if no email confirmation is required
      if (!requiresConfirmation) {
        await _updateProfileStatus(updatedUser.id);
      } else {
        print('Verification email sent! Profile will update via AuthStateChange listener.');
      }

      return true;
    } catch (e) {
      // Handle email already exists or weak password exceptions here
      return false;
    }
  }

  // Extracted helper logic to keep database changes consistent
  static Future<void> _updateProfileStatus(String userId) async {
    await _supabase
        .from('profiles')
        .update({'is_child_account': false})
        .eq('id', userId);
  }
}
