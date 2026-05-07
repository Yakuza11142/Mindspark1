class StreakRepairLogic {
  static bool canRepair(int lastActiveDaysAgo) {
    return lastActiveDaysAgo == 2; // Missed exactly yesterday
  }
  
  static int repairCost(int currentStreak) {
    return currentStreak > 50 ? 1000 : 300; // Costs more if your streak is huge
  }
}