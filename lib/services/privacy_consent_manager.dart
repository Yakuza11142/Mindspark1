import 'package:shared_preferences/shared_preferences.dart';

class PrivacyConsentManager {
  static Future<bool> needsConsentForm(String countryCode) async {
    // EU, UK, and California require explicit opt-in for personalized ads
    List<String> strictPrivacyZones =['GB', 'FR', 'DE', 'IT', 'ES', 'NL', 'IE', 'US-CA'];
    
    if (strictPrivacyZones.contains(countryCode)) {
      final prefs = await SharedPreferences.getInstance();
      return !(prefs.getBool('gdpr_consent_given') ?? false);
    }
    return false; // Nigeria/India/etc. default to false (less strict)
  }
}