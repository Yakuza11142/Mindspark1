class ExamTimeManager {
  static int calculatePace(int timeElapsed, int questionsAnswered) {
    if (questionsAnswered == 0) return 0;
    return timeElapsed ~/ questionsAnswered; // Seconds per question
  }
}