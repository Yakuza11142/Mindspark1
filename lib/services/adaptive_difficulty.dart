class AdaptiveDifficulty {
  static String getNextLevel(int currentStreak) {
    if (currentStreak > 5) return "Hard";
    if (currentStreak > 2) return "Medium";
    return "Easy";
  }
}