import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class ShortsGenerator {
  static Future<String> getQuickFact(String category) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
    final res = await model.generateContent([Content.text("Give me one mind-blowing, 2-sentence fact about $category.")]);
    return res.text ?? "Did you know learning increases brain density?";
  }
}