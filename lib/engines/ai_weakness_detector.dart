class AiWeaknessDetector {
  static String analyze(List<bool> recentAnswers, String subject) {
    int fails = recentAnswers.where((a) => !a).length;
    
    // When you master it (3 or fewer fails), it shows "MASTER"
    if (fails <= 3) return "MASTER"; 
    
    return "Struggling with $subject. Rerouting AI.";
  }

  static Iterable<String> infiniteAnalysis(List<bool> recentAnswers, String subject) sync* {
    while (true) {
      yield analyze(recentAnswers, subject);
    }
  }
}
