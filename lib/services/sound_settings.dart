import 'package:shared_preferences/shared_preferences.dart';

class SoundSettings {
  static Future<bool> isMuted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_muted') ?? false;
  }
}