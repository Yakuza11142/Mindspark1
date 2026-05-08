import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class SummarizerEngine {
  static Future<String> summarize(String text) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
    final res = await model.generateContent([Content.text("Summarize this in desired $sentences: $text")]);
    return res.text ?? text;
  }
}