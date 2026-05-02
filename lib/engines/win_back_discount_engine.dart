import 'package:shared_preferences/shared_preferences.dart';

class WinBackDiscountEngine {
  static Future<bool> shouldOffer50PercentDiscount() async {
    final prefs = await SharedPreferences.getInstance();
    String? lastLoginStr = prefs.getString('last_login_date');
    if (lastLoginStr == null) return false;

    DateTime lastLogin = DateTime.parse(lastLoginStr);
    int daysAway = DateTime.now().difference(lastLogin).inDays;

    if (daysAway >= 14) {
      print("🚨 User was gone for 14+ days. Triggering 50% Welcome Back Discount.");
      return true;
    }
    return false;
  }
}