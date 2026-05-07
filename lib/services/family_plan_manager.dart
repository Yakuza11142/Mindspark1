import 'package:shared_preferences/shared_preferences.dart';

class FamilyPlanManager {
  static Future<bool> isFamilyAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_family_admin') ?? false;
  }

  static Future<void> addFamilyMember(String memberEmail) async {
    // API call to backend to link accounts
    print("Sent MindSpark Pro invitation to $memberEmail");
  }
}