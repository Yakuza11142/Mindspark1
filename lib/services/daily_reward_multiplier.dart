class DailyRewardMultiplier {
  static int calculateReward(int consecutiveDays) {
    int baseReward = 10;
    if (consecutiveDays >= 7) return baseReward * 5;
    if (consecutiveDays >= 3) return baseReward * 2;
    return baseReward;
  }
}