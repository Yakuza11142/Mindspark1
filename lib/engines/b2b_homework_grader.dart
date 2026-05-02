class B2bHomeworkGrader {
  static int autoGradeMultipleChoice(List<String> studentAnswers, List<String> correctAnswers) {
    int score = 0;
    for (int i = 0; i < studentAnswers.length; i++) {
      if (studentAnswers[i] == correctAnswers[i]) score++;
    }
    return score;
  }
}