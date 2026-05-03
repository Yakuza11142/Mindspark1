class TokenExpiryWatcher {
  static int tokensUsedToday = 0;
  
  static void logUsage(int tokens) {
    tokensUsedToday += tokens;
    if (tokensUsedToday > 500000) {
      print("WARNING: Nearing daily API limits.");
    }
  }
}