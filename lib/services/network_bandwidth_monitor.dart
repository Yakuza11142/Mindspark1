import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkBandwidthMonitor {
  static Future<String> getVideoQuality() async {
    var connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.mobile) {
      return "medium"; // Pexels SD
    }
    return "large"; // Pexels 4K HD for WiFi
  }
}