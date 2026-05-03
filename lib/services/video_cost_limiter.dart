class VideoCostLimiter {
  static int currentSessionSeconds = 0;
  // 2 hours = 7200 seconds
  static const int MAX_SESSION_SECONDS = 7200; 

  static bool canKeepTalking() {
    if (currentSessionSeconds >= MAX_SESSION_SECONDS) {
      print("🛑 SESSION LIMIT: Video quota exhausted.");
      return false;
    }
    
    currentSessionSeconds += 15; 
    return true;
  }
}
