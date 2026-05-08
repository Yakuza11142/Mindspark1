class PracticeModeEngine {
  // Logic: User answers 3 review questions correctly -> Get 1 Heart
  static int correctAnswers = 0;
  
  static bool checkAnswer(bool isCorrect) {
    if (isCorrect) correctAnswers++;
    if (correctAnswers >= 3) {
      correctAnswers = 0;
      return true; // Reward Heart
    }
    return false;
  }
}