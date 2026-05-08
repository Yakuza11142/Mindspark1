import 'package:connectivity_plus/connectivity_plus.dart';
import 'offline_queue.dart';

class SyncWorker {
  static void init() {
    Connectivity().onConnectivityChanged.listen((event) {
      if (event != ConnectivityResult.none) {
        _uploadQueue();
      }
    });
  }

  static void _uploadQueue() {
    // Read from OfflineQueue and send to server/firebase
    print("Syncing data to cloud...");
  }
}