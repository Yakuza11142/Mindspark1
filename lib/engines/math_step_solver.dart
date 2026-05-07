import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class MathStepSolver {
  static Future<String> solve(String equation) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
    final prompt = "Solve '$equation' step-by-step. Use LaTeX math formatting. Explain the rule used in each step.";
    try {
      final res = await model.generateContent([Content.text(prompt)]);
      return res.text ?? "Error solving.";
    } catch (e) {
      return "Math Engine overloaded.";
    }
  }
}