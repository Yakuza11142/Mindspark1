import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class GlobalChatTranslation {
  static Future<String> autoTranslate(String message, String targetLang) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
    final res = await model.generateContent([Content.text("Translate exactly to $targetLang: '$message'")]);
    return res.text ?? message;
  }
}