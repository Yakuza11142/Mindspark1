import 'package:shared_preferences/shared_preferences.dart';

class BandwidthThrottle {
  static Future<bool> shouldCompressData() async {
    final prefs = await SharedPreferences.getInstance();
    bool dataSaver = prefs.getBool('data_saver_mode') ?? false;
    return dataSaver; // If true, the app will drop video quality and skip 3D downloads
  }
}