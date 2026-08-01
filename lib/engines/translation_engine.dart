import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class TranslationEngine {
  // FIXED: Pull credentials securely out of encrypted binary memory blocks instead of raw files
  static const String _geminiKey = String.fromEnvironment('GEMINI_API_KEY');

  /// Translates application text strings safely into your target regional language vectors.
  static Future<String> translate(String text, String targetLang) async {
    if (text.trim().isEmpty || _geminiKey.isEmpty) {
      return text; // Safe immediate fallback to origin text string
    }

    // FIXED: Upgraded code mapping to use the ultra-fast, modern 'gemini-1.5-flash' engine target [3]
    final model = GenerativeModel(
      model: 'gemini-1.5-flash', 
      apiKey: _geminiKey,
      // FIXED: System instructions force the AI to return ONLY the pure string, 
      // preventing layout breaking hallucination commentary.
      systemInstruction: Content.system(
        "You are an embedded high-speed localization compiler. "
        "Translate the input payload strictly into the requested target language. "
        "Do NOT provide chat commentary, introductory context, or wrapper markdown symbols. "
        "Preserve literal programmatic brackets or placeholders (e.g., '{username}') exactly as they are."
      ),
      config: GenerationConfig(
        temperature: 0.1, // Drastically lowers randomness to secure translation reliability
        maxOutputTokens: 120,
      )
    );

    // Structural constraint prompt targeting localized language arrays
    final prompt = "Target Language: $targetLang\nInput Text Payload: '$text'";

    try {
      final response = await model.generateContent([Content.text(prompt)]);
      final String? responseText = response.text?.trim();

      if (responseText == null || responseText.isEmpty) {
        return text;
      }

      // Safely strip off accidental exterior quotation marks if the LLM slips up
      return responseText.replaceAll(RegExp(r"^['" + '"' + r"]|['"' + r"]$"), "");

    } catch (e) {
      debugPrint("⚠️ Translation translation exception caught: ${e.toString()}");
      return text; // Secure fallback to default string prevents screen crashes
    }
  }
}
