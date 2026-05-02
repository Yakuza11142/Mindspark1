import 'package:connectivity_plus/connectivity_plus.dart';

class CellularDataOptimizer {
  static Future<bool> isOnMobileData() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    // V6 connectivity_plus returns a list, check if any is mobile
    return connectivityResult.contains(ConnectivityResult.mobile);
  }

  static Future<void> pauseHeavyTasks() async {
    if (await isOnMobileData()) {
      print("📶 Mobile Data Detected. Pausing 3D Model pre-fetching and 4K Videos.");
    }
  }
}