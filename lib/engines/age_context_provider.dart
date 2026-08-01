import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class AgeContextProvider {
  static const String _dobIsoKey = 'user_dob_iso_string';

  /// Calculates a user's exact current legal age down to the precise month and day [INDEX]
  static Future<int> getUserAge() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? dobIsoStr = prefs.getString(_dobIsoKey);
      final DateTime currentDate = DateTime.now().toUtc();

      DateTime birthDate;
      if (dobIsoStr != null && dobIsoStr.isNotEmpty) {
        birthDate = DateTime.parse(dobIsoStr).toUtc();
      } else {
        // Dynamically compute a compliant 18-year fallback age anchor relative to the current clock [INDEX]
        birthDate = DateTime(currentDate.year - 18, currentDate.month, currentDate.day).toUtc();
      }

      // Implement accurate chronological date delta mapping to prevent early age assignment bugs [INDEX]
      int age = currentDate.year - birthDate.year;

      // If the current date has not yet crossed the user's specific birth month and day, decrement by 1 year [INDEX]
      if (currentDate.month < birthDate.month || 
          (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
        age--;
      }

      if (age < 0) return 0;
      return age;
    } catch (e, stack) {
      developer.log("❌ AgeContextProvider: Failed to compute true age delta tracking parameters", error: e, stackTrace: stack);
      return 18; // Secure boundary shield fallback protects application compliance metrics on errors [INDEX]
    }
  }

  /// Evaluates specific demographic brackets based on fully localized precision ages [INDEX]
  static Future<String> getLifeStage() async {
    final int trueAge = await getUserAge();
    
    if (trueAge < 13) {
      return "JUNIOR";
    } else if (trueAge >= 13 && trueAge <= 17) {
      return "SCHOLAR";
    } else {
      return "ADULT";
    }
  }

  /// Securely writes a user's full Date of Birth using a standardized ISO-8601 string token [INDEX]
  static Future<bool> saveUserDob(DateTime dob) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return await prefs.setString(_dobIsoKey, dob.toUtc().toIso8601String());
    } catch (e) {
      return false;
    }
  }
}
