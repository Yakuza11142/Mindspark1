import 'dart:math';

class MathUtils {
  // Safe static instance of Random prevents resetting the seed on every single calculation loop
  static final Random _random = Random();

  static String cleanLatex(String aiOutput) {
    if (aiOutput.isEmpty) return "";

    // 1. Uses a comprehensive regex block to strip away any opening ```latex, ```math, or ```tex wrappers safely
    String cleaned = aiOutput.replaceAll(RegExp(r'```(?:latex|math|tex)?', caseSensitive: false), '');
    
    return cleaned.trim();
  }

  static int randomBetween(int min, int max) {
    // 2. CRUCIAL structural guard prevents division by zero crashes if bounds are passed incorrectly
    if (min >= max) return min;

    // 3. Utilizes Dart's standard pseudo-random number generator for uniform distribution math values
    return min + _random.nextInt(max - min);
  }
}
