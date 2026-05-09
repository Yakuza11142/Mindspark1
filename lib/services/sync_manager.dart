import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SyncManager {
  static Future<void> syncData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) return;

    final prefs = await SharedPreferences.getInstance();
    List<String>? unsynced = prefs.getStringList('unsynced_data');
    
    if (unsynced != null && unsynced.isNotEmpty) {
      // Loop through and upload to Firebase (Placeholder)
      print("Syncing ${unsynced.length} items to cloud...");
      await prefs.remove('unsynced_data');
    }
  }
}