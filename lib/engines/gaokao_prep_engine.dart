import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class GaokaoPrepEngine {
  static Future<String> generateHardcoreQuestion(String subject) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
    final prompt = "Generate a university-level, extreme difficulty multiple choice question for the Chinese Gaokao exam in $subject. Require advanced critical thinking.";
    final res = await model.generateContent([Content.text(prompt)]);
    return res.text ?? "Error";
  }
}