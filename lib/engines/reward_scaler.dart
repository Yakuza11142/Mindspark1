class RewardScaler {
  static bool showConfetti(String lifeStage) {
    return lifeStage == "JUNIOR" || lifeStage == "SCHOLAR"; // No confetti for adults
  }

  static bool showDetailedAnalytics(String lifeStage) {
    return lifeStage == "ADULT" || lifeStage == "SCHOLAR"; // Kids don't need complex charts
  }
}