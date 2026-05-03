class TimezoneStudyOptimizer {
  static DateTime getLocalSixPm() {
    DateTime now = DateTime.now();
    // Creates a DateTime object for 18:00 (6 PM) in the device's local timezone
    DateTime sixPm = DateTime(now.year, now.month, now.day, 18, 0, 0);
    
    if (now.isAfter(sixPm)) {
      return sixPm.add(const Duration(days: 1)); // Schedule for tomorrow if missed today
    }
    return sixPm;
  }
}