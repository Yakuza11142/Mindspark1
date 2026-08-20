import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LegalService {
  /// Wipes local cached user data, tokens, and preferences.
  static Future<void> wipeUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      debugPrint("User data successfully wiped.");
    } catch (e) {
      debugPrint("Error wiping user data: $e");
    }
  }

  static String get termsOfService => '''
Terms of Service:
1. Usage: You agree to use this platform in accordance with applicable rules and guidelines.
2. Safety: Moderation and filters are active to enforce appropriate conduct.
3. Content: Unauthorized replication of platform materials is prohibited.
''';

  static String get privacyPolicy => '''
Privacy Policy:
1. Data Collection: We process essential technical data required to deliver core services.
2. Security: All stored credentials and session tokens are encrypted and secure.
3. Data Removal: Users retain full rights to clear local state via app settings.
''';
}
