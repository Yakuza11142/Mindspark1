class WaecGradingAlgorithm {
  static String getGrade(int rawScore) {
    // WAEC 9-point grading system standard bounds
    if (rawScore >= 75) return "A1 (Excellent)";
    if (rawScore >= 70) return "B2 (Very Good)";
    if (rawScore >= 65) return "B3 (Good)";
    if (rawScore >= 60) return "C4 (Credit)";
    if (rawScore >= 55) return "C5 (Credit)";
    if (rawScore >= 50) return "C6 (Credit)";
    if (rawScore >= 45) return "D7 (Pass)";
    if (rawScore >= 40) return "E8 (Pass)";
    return "F9 (Fail)";
  }
}