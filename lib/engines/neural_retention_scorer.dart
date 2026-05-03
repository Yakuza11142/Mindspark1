class NeuralRetentionScorer {
  static double calculateMemoryDecay(int hoursSinceLastReview, bool studiedAtNight) {
    // Ebbinghaus Forgetting Curve formula modified for fatigue
    double decayRate = studiedAtNight ? 1.5 : 1.0; 
    double retention = 100 * (1 / (1 + (hoursSinceLastReview / 24) * decayRate));
    return retention; // Returns percentage of memory kept
  }
}