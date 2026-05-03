class CbtSpeedAnalyzer {
  static bool isTooSlow(int secondsSpent) {
    // JAMB gives you ~40 seconds per question on average
    if (secondsSpent > 40) {
      print("⚠️ WARNING: You are too slow move on to the next question, then later come back to the ones you do not understand.");
      return true;
    }
    return false;
  }
}