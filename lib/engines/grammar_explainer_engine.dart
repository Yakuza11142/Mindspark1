import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class GrammarExplainerEngine {
  static Future<String> explainRule(String sentence, String mistake) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
    final prompt = "Explain the grammar rule for why '$mistake' is wrong in the sentence: '$sentence'. Keep it short and simple.";
    
    try {
      final res = await model.generateContent([Content.text(prompt)]);
      return res.text ?? "Grammar rule not found.";
    } catch (e) {
      return "Check your spelling and tense.";
    }
  }
}