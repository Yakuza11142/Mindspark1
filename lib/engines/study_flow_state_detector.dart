class StudyFlowStateDetector {
  static int _consecutiveCorrectFastAnswers = 0;

  static bool isUserInFlow(int secondsTaken, bool isCorrect) {
    if (isCorrect && secondsTaken < 15) {
      _consecutiveCorrectFastAnswers++;
    } else {
      _consecutiveCorrectFastAnswers = 0;
    }
    return _consecutiveCorrectFastAnswers >= 5; // Flow state achieved after 5 fast correct answers
  }
}