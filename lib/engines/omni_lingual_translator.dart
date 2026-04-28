import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets_fusion.dart';

class OmniLingualTranslator {
  static Future<String> generateInLanguage(String topic, String targetLanguage, String personaPrompt) async {
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: SecretsFusion.geminiKey);
    final prompt = """
    $personaPrompt
    Explain '$topic'. 
    CRITICAL: You must write your entire response in $targetLanguage. Ensure the tone matches your persona.
    """;
    
    try {
      final res = await model.generateContent([Content.text(prompt)]);
      return res.text ?? "Translation Error.";
    } catch (e) {
      return "Network Error. Please try again.";
    }
  }
}