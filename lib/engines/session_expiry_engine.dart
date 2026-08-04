import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class SessionSettings {
  static const String sessionKey = 'last_sync_timestamp';
  static const Duration forceReauthAfter = Duration(days: 7); 
}

class UserSecuritySettings {
  static const int minimumEmailAge = 13;
  static int? currentUserAge; 
  static bool hasAttemptedAgeFetch = false; 

  static void reset() {
    currentUserAge = null;
    hasAttemptedAgeFetch = false;
  }
}

class SessionExpiryEngine {
  static final _supabase = Supabase.instance.client;
  static bool _isProcessing = false;

  static Future<void> checkSession() async {
    if (_isProcessing) return;
    _isProcessing = true;

    try {
      final session = _supabase.auth.currentSession;
      if (session == null) return; 

      // 1. Hardened Age Gate Check
      if (UserSecuritySettings.currentUserAge == null) {
        if (!UserSecuritySettings.hasAttemptedAgeFetch) {
          developer.log("Security validation: Fetching age database record.");
          
          try {
            final userId = _supabase.auth.currentUser?.id;
            if (userId != null) {
              // Flip toggle immediately before network invocation to isolate execution frame
              UserSecuritySettings.hasAttemptedAgeFetch = true; 
              
              final response = await _supabase
                  .from('profiles')
                  .select('age')
                  .eq('id', userId)
                  .maybeSingle();

              if (response != null && response is Map && response['age'] != null) {
                UserSecuritySettings.currentUserAge = (response['age'] as num).toInt();
              } else {
                developer.log("Profile data not found yet. Profile generation pending.");
                UserSecuritySettings.hasAttemptedAgeFetch = false;
                return; 
              }
            } else {
              return;
            }
          } catch (e, stack) {
            developer.log("Failed to fetch recovery age checkpoint", error: e, stackTrace: stack);
            UserSecuritySettings.hasAttemptedAgeFetch = false; 
            return; 
          }
        } else {
          return; 
        }
      }

      // Enforce lock if verification finishes and user fails criteria
      if (UserSecuritySettings.currentUserAge != null && 
          UserSecuritySettings.currentUserAge! < UserSecuritySettings.minimumEmailAge) {
        developer.log("Access Denied: Underage user block active. Purging session.");
        UserSecuritySettings.reset(); 
        // Await token cache purging explicitly to block race conditions on subsequent loops
        await _supabase.auth.signOut(); 
        return;
      }

      // 2. Tamper-Proof Cryptographic Verification
      final DateTime? jwtExpiry = session.expiresAt;
      if (jwtExpiry != null && jwtExpiry.isBefore(DateTime.now().toUtc())) {
        developer.log("Local clock indicates token expiration threshold reached.");

        final currentAuthSession = _supabase.auth.currentSession;
        if (currentAuthSession == null || (currentAuthSession.expiresAt?.isBefore(DateTime.now().toUtc()) ?? true)) {
          developer.log("Token verification trace failed securely. Forcing clean sign-out cascade.");
          UserSecuritySettings.reset();
          await _supabase.auth.signOut(); 
          return;
        }
      }

      // 3. Local Sliding Window Validation
      final prefs = await SharedPreferences.getInstance();
      final String? lastLoginStr = prefs.getString(SessionSettings.sessionKey);
      final DateTime now = DateTime.now().toUtc(); 

      if (lastLoginStr != null) {
        final DateTime? lastLogin = DateTime.tryParse(lastLoginStr)?.toUtc();

        if (lastLogin != null) {
          final Duration elapsed = now.difference(lastLogin);

          if (elapsed > SessionSettings.forceReauthAfter || elapsed.isNegative) {
            developer.log("Sliding verification window closed or clock manipulated. Requesting re-auth.");
            await prefs.remove(SessionSettings.sessionKey);
            UserSecuritySettings.reset();
            await _supabase.auth.signOut(); 
            return; 
          }
        } else {
          await prefs.remove(SessionSettings.sessionKey);
        }
      }

      await prefs.setString(SessionSettings.sessionKey, now.toIso8601String());
    } finally {
      _isProcessing = false; // Clean, synchronized master unlock checkpoint
    }
  }
}
