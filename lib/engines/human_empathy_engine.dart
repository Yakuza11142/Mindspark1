class HumanEmpathyEngine {
  static String analyzeUserMood(String userInput, int mistakesMadeToday) {
    if (mistakesMadeToday > 5 || userInput.contains("I don't get it") || userInput.contains("hard")) {
      return "FRUSTRATED";
    }
    if (userInput.contains("!") || userInput.contains("passed") || userInput.contains("easy")) {
      return "EXCITED";
    }
    return "NEUTRAL";
  }
}