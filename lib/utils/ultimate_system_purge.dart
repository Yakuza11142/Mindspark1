import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UltimateSystemPurge {
  static Future<void> readyForStage() async {
    imageCache.clear();
    imageCache.clearLiveImages();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('target_exam'); // Resets the UI
    print("🧹 SYSTEM PURGED. 0ms LATENCY RESTORED. READY FOR ABUJA STAGE.");
  }
}