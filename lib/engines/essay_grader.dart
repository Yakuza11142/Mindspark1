import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class EssayGrader {
  static Future<String> grade(String essay, int maxScore) async {
    final finalMaxScore = maxScore.clamp(1, 100);

    final model = GenerativeModel(
      // Using 'gemini-pro-latest' instead of 'gemini-3.1-pro-latest' 
      // ensures it rolls over to 3.2, 3.3, etc., automatically.
      model: 'gemini-pro-latest', 
      apiKey: Secrets.geminiKey,
    );

    final prompt = "Grade this essay out of $finalMaxScore and give feedback: $essay";

    try {
      final res = await model.generateContent([Content.text(prompt)]);
      return res.text ?? "Error: No feedback received.";
    } catch (e) {
      return "Grading failed: $e";
    }
  }
}
