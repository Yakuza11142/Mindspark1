import 'package:shared_preferences/shared_preferences.dart';

class SoundVolumeController {
  static Future<void> setMusicVol(double vol) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('music_vol', vol);
  }
  static Future<double> getMusicVol() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('music_vol') ?? 0.5;
  }
}