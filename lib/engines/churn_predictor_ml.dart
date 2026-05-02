import 'package:shared_preferences/shared_preferences.dart';

class ChurnPredictorMl {
  static Future<bool> isUserAtRisk() async {
    final prefs = await SharedPreferences.getInstance();
    bool isPro = prefs.getBool('is_pro_unlocked') ?? false;
    String? lastLoginStr = prefs.getString('last_login_date');
    
    if (!isPro || lastLoginStr == null) return false;
    
    int daysAway = DateTime.now().difference(DateTime.parse(lastLoginStr)).inDays;
    return daysAway >= 5; // 5 days inactive = High Risk of Cancellation
  }
}