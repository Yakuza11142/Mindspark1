class ElevenLabsTimestampParser {
  static void syncGestureToWord(String word, int timeMs) {
    if (word.toLowerCase() == "crucial" || word.toLowerCase() == "important") {
      print("👋 Triggering 'Hand_Emphasize' animation at $timeMs ms.");
    }
  }
}