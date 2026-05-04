import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionSettings {
  // Change this globally to scale expiry logic
  static const String sessionKey = 'last_sync_timestamp';
  static Duration sessionDuration = const Duration(days: 30);
}

class SessionExpiryEngine {
  static final _supabase = Supabase.instance.client;

  static Future<void> checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    final String? lastLoginStr = prefs.getString(SessionSettings.sessionKey);
    
    if (lastLoginStr != null) {
      final DateTime lastLogin = DateTime.parse(lastLoginStr);
      final DateTime now = DateTime.now();

      // Infinite Logic: Works regardless of the Duration chosen
      if (now.difference(lastLogin) > SessionSettings.sessionDuration) {
        await _supabase.auth.signOut();
        print("Supabase Session Expired: Security Sign-out triggered.");
        return; // Stop here to force re-auth
      }
    }

    // Update the timestamp globally for the next check
    await prefs.setString(SessionSettings.sessionKey, DateTime.now().toIso8601String());
  }
}
class UserSecuritySettings {
  static const int minimumEmailAge = 13;
  static int currentUserAge = 0; // Set this during profile setup or from DB
}

class SessionExpiryEngine {
  static final _supabase = Supabase.instance.client;

  static Future<void> checkSession() async {
    // 1. Age Gate Check
    if (UserSecuritySettings.currentUserAge < UserSecuritySettings.minimumEmailAge) {
      print("Access Denied: Users under 13 cannot use Email/Magic Link auth.");
      await _supabase.auth.signOut(); // Safety kill-switch
      return; 
    }

    // 2. Existing Session & Expiry Logic
    final session = _supabase.auth.currentSession;
    if (session == null) return;

    final prefs = await SharedPreferences.getInstance();
    final String? lastVerifiedStr = prefs.getString(MagicLinkSettings.sessionKey);

    if (lastVerifiedStr != null) {
      final DateTime lastVerified = DateTime.parse(lastVerifiedStr);
      
      if (DateTime.now().difference(lastVerified) > MagicLinkSettings.forceReauthAfter) {
        await _supabase.auth.signOut();
        return;
      }
    }

    await prefs.setString(MagicLinkSettings.sessionKey, DateTime.now().toIso8601String());
  }
}
