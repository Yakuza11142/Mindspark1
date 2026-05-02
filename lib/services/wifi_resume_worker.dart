import 'package:connectivity_plus/connectivity_plus.dart';

class WifiResumeWorker {
  static void listenForWifi() {
    Connectivity().onConnectivityChanged.listen((results) {
      if (results.contains(ConnectivityResult.wifi)) {
        print("🌐 Wi-Fi Connected. Uploading offline analytics to Supabase...");
        // Execute heavy syncs
      }
    });
  }
}