class FinalScoreNormalizer {
  static int applyCurve(int rawScore, int totalQuestions) {
    double percentage = rawScore / totalQuestions;
    // JAMB standardizes scores. A raw 60% might curve to a 250/400.
    return (percentage * 400).round();
  }
}