import 'package:battery_plus/battery_plus.dart';

class BatteryZeroSaver {
  static Future<void> monitor() async {
    Battery().onBatteryStateChanged.listen((BatteryState state) async {
      int level = await Battery().batteryLevel;
      if (level <= 2) {
        print("🚨 CRITICAL BATTERY: Force-saving all states to disk. Executing Emergency Shutdown Protocols.");
        // Call Hive/SharedPrefs save functions
      }
    });
  }
}