import 'package:shared_preferences/shared_preferences.dart';

class AgeContextProvider {
  static Future<int> getUserAge() async {
    final prefs = await SharedPreferences.getInstance();
    int birthYear = prefs.getInt('user_dob_year') ?? 2008; // Default 18
    return DateTime.now().year - birthYear;
  }

  static Future<String> getLifeStage() async {
    int age = await getUserAge();
    if (age < 13) return "JUNIOR";
    if (age >= 13 && age <= 17) return "SCHOLAR";
    return "ADULT";
  }
}