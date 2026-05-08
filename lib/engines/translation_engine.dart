import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class TranslationEngine {
  static Future<String> translate(String text, String targetLang) async {
    // targetLang: 'French', 'Swahili', 'Hausa', 'Yoruba'
    final model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
    final prompt = "Translate this UI text to $targetLang. Keep it short: '$text'";
    
    try {
      final res = await model.generateContent([Content.text(prompt)]);
      return res.text ?? text;
    } catch (e) {
      return text; // Fallback to English
    }
  }
}