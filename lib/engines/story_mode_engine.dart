import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class StoryModeEngine {
  static Future<String> narrate(String topic) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
    final prompt = "Tell a short, exciting adventure story that teaches the concept of '$topic'. Use characters and dialogue.";
    final res = await model.generateContent([Content.text(prompt)]);
    return res.text ?? "Once upon a time...";
  }
}