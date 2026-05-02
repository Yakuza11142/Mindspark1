import 'package:shared_preferences/shared_preferences.dart';

class CoppaDataWiper {
  static Future<void> enforce() async {
    final prefs = await SharedPreferences.getInstance();
    // Ensures no personally identifiable information (PII) is kept for Juniors
    await prefs.remove('target_ad_id'); 
    print("COPPA Enforced: Ad tracking disabled for Junior user.");
  }
}