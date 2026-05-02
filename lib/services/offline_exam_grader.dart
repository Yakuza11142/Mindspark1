class OfflineExamGrader {
  static int calculateScore(Map<int, String> studentAnswers, Map<int, String> answerKey) {
    int score = 0;
    studentAnswers.forEach((key, val) {
      if (answerKey[key] == val) score++;
    });
    return score;
  }
}