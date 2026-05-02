class AfternoonTrafficRouter {
  static String getOptimalAiModel(bool isPro) {
    int hour = DateTime.now().hour;
    bool isRushHour = hour >= 15 && hour <= 19; // 3 PM to 7 PM

    if (isPro) return "gpt-4-turbo"; // Pros always get the best
    
    if (isRushHour) {
      print("🚦 RUSH HOUR ACTIVE: Routing free users to Hyper-Fast Groq LPU.");
      return "llama3-8b-8192"; 
    }
    
    return "gemini-3.1-pro"; // Standard off-peak model
  }
}