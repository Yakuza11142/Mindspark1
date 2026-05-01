class ConfidenceIntervalTracker {
  static void logAnswer(bool isCorrect, String confidenceLevel) {
    if (isCorrect && confidenceLevel == "Guessed") {
      print("⚠️ User guessed correctly. Marking topic for re-evaluation tomorrow.");
    } else if (isCorrect && confidenceLevel == "100% Sure") {
      print("✅ True Mastery Achieved. Archiving topic.");
    }
  }
}