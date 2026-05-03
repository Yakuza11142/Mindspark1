class OfflineStreakReconciler {
  static int syncOfflineDays(int cloudStreak, int offlineDaysLogged) {
    print("Syncing $offlineDaysLogged offline study days to Supabase...");
    return cloudStreak + offlineDaysLogged;
  }
}