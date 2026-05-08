import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class QuizFromText {
  static Future<String> generate(String text) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
    final res = await model.generateContent([Content.text("Create 1 multiple choice question based on this text: $text")]);
    return res.text ?? "Error";
  }
}