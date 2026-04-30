class LocalizedGreetingService {
  static String getGreeting(String countryCode, int hour) {
    if (countryCode == 'NG') {
      if (hour < 12) return "Good morning, boss. Ready to grind?";
      return "How far? Let's crush this JAMB.";
    }
    if (countryCode == 'US') {
      return "What's up? Let's get to studying.";
    }
    return "Welcome to MindSpark.";
  }
}