import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'anonymous_kid_auth.dart';
import '../../screens/auth/magic_login_screen.dart';
import '../../screens/main_layout_screen.dart';

class AuthFlowDirector {
  static final _supabase = Supabase.instance.client;

  static Future<void> routeUser(BuildContext context) async {
    // 1. Check for an active Supabase session first
    final currentSession = _supabase.auth.currentSession;
    if (currentSession != null) {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainLayoutScreen()),
        );
      }
      return;
    }

    // 2. No active session found; proceed to age check
    final prefs = await SharedPreferences.getInstance();
    String? dobString = prefs.getString('user_dob');
    
    // Explicit 2015 fallback represents an 11-year-old child in 2026 (COPPA protected)
    DateTime birthDate = dobString != null 
        ? DateTime.parse(dobString) 
        : DateTime(2015, 1, 1); 

    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    
    if (today.month < birthDate.month || 
       (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    if (age < 13) {
      // Under 13: Establish a ghost login session
      bool success = await AnonymousKidAuth.signInGhost();
      if (success && context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainLayoutScreen()),
        );
      }
    } else {
      // 13+: Direct to standard email authentication gate
      if (context.mounted) {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (_) => const MagicLoginScreen()),
        );
      }
    }
  }
}
