import 'package:flutter/foundation.dart';
import 'package:timezone/timezone.dart' as tz; // From your pubspec.yaml
import 'package:timezone/data/latest.dart' as tz_data;

class TimezoneStudyOptimizer {
  static bool _isTimezoneDatabaseInitialized = false;

  /// Ensures time database mapping schemas are initialized safely from device storage locations
  static void initializeTimeSystem() {
    if (_isTimezoneDatabaseInitialized) return;
    try {
      tz_data.initializeTimeZones();
      _isTimezoneDatabaseInitialized = true;
      debugPrint("📅 Timezone Database fully initialized for regional scheduling tracking.");
    } catch (e) {
      debugPrint("🚨 Failed to map location data packages: ${e.toString()}");
    }
  }

  /// Calculates a precise, daylight-saving-compliant 6 PM notification timestamp.
  /// Maps scheduling metrics branchlessly relative to explicit geographical locations.
  static DateTime getLocalSixPm({String locationName = 'Africa/Lagos'}) {
    // Ensure database arrays are active before parsing mapping blocks
    initializeTimeSystem();

    try {
      // Find the specific geographical zone context safely
      final tz.Location deviceLocation = tz.getLocation(locationName);
      
      // Fetch the current absolute atomic clock tracking context for that specific zone [1]
      final tz.TZDateTime nowInZone = tz.TZDateTime.now(deviceLocation);

      // FIXED: Build a time structure bound directly to a true location timezone matrix shell.
      // This allows the clock system to handle 23-hour or 25-hour day variations seamlessly.
      tz.TZDateTime targetScheduledTime = tz.TZDateTime(
        deviceLocation,
        nowInZone.year,
        nowInZone.month,
        nowInZone.day,
        18, 0, 0, // Target exactly 6 PM local hour
      );

      // FIXED: Rollover scheduling uses native calendar mapping mechanisms instead of flat 24-hour durations.
      // This completely protects the notification loops from daylight saving time offset gaps.
      if (nowInZone.isAfter(targetScheduledTime)) {
        targetScheduledTime = tz.TZDateTime(
          deviceLocation,
          nowInZone.year,
          nowInZone.month,
          nowInZone.day + 1, // Progress to next numerical calendar block safely
          18, 0, 0,
        );
      }

      // Convert back to standard UTC or device-local formats for engine compatibility
      return targetScheduledTime;

    } catch (e) {
      debugPrint("⚠️ Timezone routing failure. Falling back onto safe device calculations: $e");
      
      // Resilient fallback layer prevents application boot crashes
      final DateTime now = DateTime.now();
      final DateTime standardSixPm = DateTime(now.year, now.month, now.day, 18, 0, 0);
      if (now.isAfter(standardSixPm)) {
        return DateTime(now.year, now.month, now.day + 1, 18, 0, 0);
      }
      return standardSixPm;
    }
  }
}
