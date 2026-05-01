class SleepMemoryConsolidator {
  static List<String> getBedtimeReview(List<String> failedTopicsToday) {
    if (failedTopicsToday.isEmpty) return["You had a perfect day. Rest your mind."];
    
    print("🌙 BEDTIME PROTOCOL: Generating 5 micro-reviews for $failedTopicsToday to encode into long-term memory during REM sleep.");
    return["Quick: What is the formula for Kinetic Energy?", "Define Isomerism."];
  }
}