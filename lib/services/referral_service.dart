import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class ReferralService {
  static Future<String> getMyCode() async {
    final prefs = await SharedPreferences.getInstance();
    String? code = prefs.getString('referral_code');
    if (code == null) {
      code = "SPARK-${Random().nextInt(99999)}";
      await prefs.setString('referral_code', code);
    }
    return code;
  }
}