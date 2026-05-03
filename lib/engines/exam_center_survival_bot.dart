class ExamCenterSurvivalBot {
  static String ask(String query) {
    if (query.toLowerCase().contains("thumbprint")) {
      return "If your thumbprint fails, wipe it on your hair to add natural oil, or use hand sanitizer. Do not panic. The officials will assist you.";
    }
    return "Focus on the exam. Breathe.";
  }
}