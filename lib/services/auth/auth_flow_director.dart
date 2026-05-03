import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'anonymous_kid_auth.dart';
import '../../screens/auth/magic_login_screen.dart';
import '../../screens/main_layout_screen.dart';

class AuthFlowDirector {
  static Future<void> routeUser(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    int birthYear = prefs.getInt('user_dob_year') ?? 2010;
    int age = DateTime.now().year - birthYear;

    if (age < 13) {
      // COPPA COMPLIANT: Ghost Login (No Email)
      bool success = await AnonymousKidAuth.signInGhost();
      if (success && context.mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainLayoutScreen()));
      }
    } else {
      // 13+: Route to Magic Link Email Screen
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MagicLoginScreen()));
    }
  }
}