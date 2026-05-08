import 'package:connectivity_plus/connectivity_plus.dart';

class OfflineModeDetector {
  static Future<bool> isOffline() async {
    var res = await Connectivity().checkConnectivity();
    return res == ConnectivityResult.none;
  }
}