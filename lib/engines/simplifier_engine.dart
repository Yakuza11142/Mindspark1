import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class SimplifierEngine {
  static Future<String> simplify(String text) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
    final res = await model.generateContent([Content.text("Rewrite this so a 5 year old understands: $text")]);
    return res.text ?? text;
  }
}