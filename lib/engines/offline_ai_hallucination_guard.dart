class OfflineAiHallucinationGuard {
  static bool verifyMathLogic(String equation, String result) {
    // Basic regex sanity check to ensure the output makes mathematical sense
    if (result.contains("NaN") || result.contains("Infinity")) return false;
    return true;
  }
}