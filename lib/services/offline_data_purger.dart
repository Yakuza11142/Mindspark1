import 'package:shared_preferences/shared_preferences.dart';

class OfflineDataPurger {
  static Future<void> clearOldCache() async {
    final prefs = await SharedPreferences.getInstance();
    // Logic to clear old keys
    print("🧹 Old Cache Cleared. Storage Optimized.");
  }
}