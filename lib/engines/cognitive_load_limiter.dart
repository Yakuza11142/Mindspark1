class CognitiveLoadLimiter {
  static int _wordsReadToday = 0;

  static void addWords(int count) {
    _wordsReadToday += count;
  }

  static bool isBrainOverloaded() {
    return _wordsReadToday > 3000;
  }
}