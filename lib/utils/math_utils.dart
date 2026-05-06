class MathUtils {
  static String cleanLatex(String aiOutput) {
    // Removes weird markdown from Gemini so the Math equation renders beautifully
    return aiOutput.replaceAll('```latex', '').replaceAll('```', '').trim();
  }
  static int randomBetween(int min, int max) => min + (DateTime.now().millisecondsSinceEpoch % (max - min));
}