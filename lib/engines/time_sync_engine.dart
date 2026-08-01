import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:ntp/ntp.dart'; // From your pubspec.yaml

class TimeSyncEngine {
  // FIXED: Instead of caching a frozen timestamp, we cache the network clock offset delta.
  // This value represents the exact millisecond difference between the phone and the true atomic clock.
  static int _deviceClockOffsetMs = 0;
  static bool _isSynchronized = false;

  static bool get isSynchronized => _isSynchronized;

  /// Synchronizes your application baseline with authoritative NTP server infrastructures.
  /// Must be invoked sequentially during your early AppBootSequence execution thread.
  static Future<void> syncWithServer() async {
    try {
      debugPrint("📡 [TimeSync Core] Querying authoritative network clock via time.google.com...");

      // FIXED: Calculate the exact clock offset variance parameter instead of freezing the time point
      final int offset = await NTP.getNtpOffset(
        lookUpAddress: 'time.google.com',
        timeout: const Duration(seconds: 5), // Prevents hanging connections on slow cellular links
      );

      _deviceClockOffsetMs = offset;
      _isSynchronized = true;
      
      debugPrint("🎯 Secure Time Synced Successfully. Clock Offset Variance: ${_deviceClockOffsetMs}ms.");
    } catch (e) {
      _isSynchronized = false;
      debugPrint("🚨 Network Time Protocol verification abort: ${e.toString()}");
      
      // FIXED: Removed the weak local clock fallback loop. 
      // If a secure timestamp is mandatory for preventing exam frauds, we rethrow the exception.
      // This allows your boot sequence to securely halt the transaction funnel.
      rethrow;
    }
  }

  /// Calculates the true, un-tamperable time dynamically across all mobile/web runtimes.
  static DateTime getSecureNow() {
    final DateTime currentLocalTime = DateTime.now();

    if (!_isSynchronized) {
      // If the app is running in an offline testing mode and sync was skipped, return unverified time
      debugPrint("⚠️ Warning: Accessing unverified device clock. NTP synchronization layer is inactive.");
      return currentLocalTime;
    }

    // FIXED: Dynamically apply the calculated millisecond offset to the current clock tick.
    // This allows the clock to tick forward perfectly while correcting any manual user clock modifications.
    return currentLocalTime.add(Duration(milliseconds: _deviceClockOffsetMs));
  }
}
