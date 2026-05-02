import 'dart:math';
import 'dart:async';

class CbtNetworkFailureSim {
  static Future<bool> simulateCrash() async {
    int chance = Random().nextInt(100);
    if (chance < 5) { // 5% chance of a "Server Drop"
      print("🚨 SIMULATED EXAM CRASH: Network timeout.");
      await Future.delayed(const Duration(seconds: 5)); // Freeze for 5 seconds
      print("✅ EXAM RESTORED: Time re-synced.");
      return true;
    }
    return false;
  }
}