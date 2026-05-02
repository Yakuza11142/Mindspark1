class DynamicGreetingEngine {
  static String getGreeting() {
    int hour = DateTime.now().hour;
    if (hour < 12) return "Good morning, Mastermind. 🌅";
    if (hour < 17) return "Good afternoon. Keep pushing. ⚡";
    if (hour < 21) return "Evening review session. Let's go. 🌙";
    return "Late night grind. Focus mode active. 🦉";
  }
}