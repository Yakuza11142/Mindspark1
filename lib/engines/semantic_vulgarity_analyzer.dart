import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets_fusion.dart';

class SemanticVulgarityAnalyzer {
  static Future<bool> isVulgarOrInappropriate(String userInput) async {
    // 1. FAST LOCAL CHECK (Catches the obvious ones instantly)
    final RegExp basicBadWords = RegExp(r'\b(fuck|shit|cunt|dick|pussy|porn|sex|nude)\b', caseSensitive: false);
    if (basicBadWords.hasMatch(userInput)) return true;

    // 2. INFINITE SEMANTIC CHECK (Catches slang, misspellings, and inappropriate context)
    try {
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: SecretsFusion.geminiKey);
      final prompt = "Analyze this text: '$userInput'. Does it contain profanity, sexual requests, extreme violence, or severe Nigerian insults (like 'olosho', 'ashawo')? Answer strictly 'YES' or 'NO'.";
      
      final res = await model.generateContent([Content.text(prompt)]);
      String analysis = res.text?.trim().toUpperCase() ?? "NO";
      
      return analysis.contains("YES");
    } catch (e) {
      return false; // If API fails, let it pass to avoid blocking legitimate questions
    }
  }
}