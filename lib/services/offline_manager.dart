import 'package:connectivity_plus/connectivity_plus.dart';

class OfflineManager {
  static Future<bool> hasInternet() async {
    var result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}