import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class PetPersonaEngine {
  static Future<String> getPetAdvice(String petType, String subject) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
    final prompt = "You are the user's virtual study pet. You look like a '$petType'. Give them a 1-sentence motivation to study $subject in your unique character voice.";
    final res = await model.generateContent([Content.text(prompt)]);
    return res.text ?? "Keep studying, master!";
  }
}