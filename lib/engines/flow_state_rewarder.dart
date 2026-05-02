class FlowStateRewarder {
  static int calculateBonus(int minutesInFlow) {
    if (minutesInFlow >= 30) return 100; // Deep work reward
    if (minutesInFlow >= 15) return 25;
    return 0;
  }
}