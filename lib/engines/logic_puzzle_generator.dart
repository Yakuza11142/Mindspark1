import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class LogicPuzzleGenerator {
  static Future<String> getPuzzle() async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
    final res = await model.generateContent([Content.text("Generate a short, difficult IQ logic puzzle.")]);
    return res.text ?? "Error";
  }
}