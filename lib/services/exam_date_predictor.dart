import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class ExamDatePredictor {
  static Future<String> guessExamDate(String examName) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
    final prompt = "What month and year is the next '$examName' exam usually held? Keep answer under 5 words.";
    final res = await model.generateContent([Content.text(prompt)]);
    return res.text ?? "Date Unknown";
  }
}