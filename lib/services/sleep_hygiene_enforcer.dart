class SleepHygieneEnforcer {
  static bool shouldSleep() {
    int hour = DateTime.now().hour;
    return hour >= 23 || hour <= 4; // 11 PM to 4 AM
  }

  static String getSleepMessage() {
    return "The most critical part of memory retention is sleep. MindSpark is now in Rest Mode. Close your eyes. We continue tomorrow.";
  }
}