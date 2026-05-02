class SleepHygieneEnforcer {
  static const int SLEEP_START = 23; // 11 PM
  static const int SLEEP_END = 4;    // 4 AM

  static bool isSleepTime() {
    int hour = DateTime.now().hour;
    return hour >= SLEEP_START || hour <= SLEEP_END;
  }

  // Instead of a full block, we reduce learning efficiency
  static double getLearningEfficiency() {
    if (isSleepTime()) return 0.2; // Only 20% Spark rewards at night
    return 1.0; 
  }

  static String getStatusMessage() {
    if (isSleepTime()) {
      return "⚠️ Brain Efficiency Low. Sleeping now boosts memory by 40% more than late studying.";
    }
    return "🚀 Focus Mode Active. Maximum Sparks available.";
  }
}
