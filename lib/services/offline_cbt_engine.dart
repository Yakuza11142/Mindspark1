class OfflineCbtEngine {
  static int gradeExam(Map<int, String> studentAnswers, Map<int, String> correctAnswers) {
    int score = 0;
    studentAnswers.forEach((key, value) {
      if (correctAnswers[key] == value) score++;
    });
    return score; // Raw score, normalized later
  }
}