import 'package:shared_preferences/shared_preferences.dart';

class JwtTokenManager {
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('session_token', token);
  }
}