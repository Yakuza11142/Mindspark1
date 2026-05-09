import 'dart:async';
import 'package:speech_to_text/speech_to_text.dart';

class PronunciationEngine {
  final SpeechToText _speech = SpeechToText();

  Future<int> scoreSpeech(String targetPhrase) async {
    bool available = await _speech.initialize();
    if (!available) return 0;

    final completer = Completer<int>();
    
    _speech.listen(
      listenFor: const Duration(seconds: 10), // Safety timeout
      onResult: (result) {
        if (result.finalResult) {
          final spoken = result.recognizedWords.toLowerCase().trim();
          final target = targetPhrase.toLowerCase().trim();

          // Calculate a real percentage based on string similarity
          int score = _calculateSimilarity(target, spoken);
          
          if (!completer.isCompleted) completer.complete(score);
          _speech.stop();
        }
      },
    );

    // Ensure it returns a 0 if the user doesn't speak at all
    return completer.future.timeout(
      const Duration(seconds: 11), 
      onTimeout: () => 0,
    );
  }

  /// Calculates similarity using Levenshtein distance logic
  int _calculateSimilarity(String s1, String s2) {
    if (s1 == s2) return 100;
    if (s1.isEmpty || s2.isEmpty) return 0;

    final distance = _getLevenshteinDistance(s1, s2);
    final maxLen = s1.length > s2.length ? s1.length : s2.length;
    
    // Convert distance into a percentage (0-100)
    return (((maxLen - distance) / maxLen) * 100).toInt().clamp(0, 100);
  }

  int _getLevenshteinDistance(String s, String t) {
    if (s == t) return 0;
    if (s.isEmpty) return t.length;
    if (t.isEmpty) return s.length;

    List<int> v0 = List<int>.generate(t.length + 1, (i) => i);
    List<int> v1 = List<int>.filled(t.length + 1, 0);

    for (int i = 0; i < s.length; i++) {
      v1[0] = i + 1;
      for (int j = 0; j < t.length; j++) {
        int cost = (s[i] == t[j]) ? 0 : 1;
        v1[j + 1] = [v1[j] + 1, v0[j + 1] + 1, v0[j] + cost]
            .reduce((curr, next) => curr < next ? curr : next);
      }
      for (int j = 0; j < v0.length; j++) {
        v0[j] = v1[j];
      }
    }
    return v0[t.length];
  }
}
