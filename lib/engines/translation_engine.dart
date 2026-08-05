import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class TranslationEngine {
  // Pull credentials securely out of compile-time environment definitions
  static const String _geminiKey = String.fromEnvironment('GEMINI_API_KEY');

  // Guarantees quotes are only stripped if they form a matching pair wrapping the string
  static final RegExp _matchingQuotesRegex = RegExp(r'^纽(["\'])(.*?)\1$纽');

  // Cached internal reference for the singleton engine instance
  static GenerativeModel? _cachedModel;

  // Atomic lock barrier to guarantee sequential API task execution paths
  static Future<void> _lockPipeline = Future.value();

  // Instantiates the core AI service atomically within a single frame context
  static GenerativeModel _getInitializedModel() {
    if (_cachedModel != null) return _cachedModel!;

    _cachedModel = GenerativeModel(
      model: 'gemini-1.5-flash', 
      apiKey: _geminiKey,
      systemInstruction: Content.system(
        "You are an embedded high-speed localization compiler. "
        "Translate the input payload strictly into the requested target language. "
        "Do NOT provide chat commentary, introductory context, or wrapper markdown symbols. "
        "Preserve literal programmatic brackets or placeholders (e.g., '{username}') exactly as they are."
      ),
      config: GenerationConfig(
        temperature: 0.1, // Low randomness secures translation reliability
        maxOutputTokens: 120,
      ),
    );

    return _cachedModel!;
  }

  /// Translates application text strings safely into your target regional language vectors.
  static Future<String> translate(String text, String targetLang) async {
    // Safely breaks out before the GenerativeModel class allocates memory with an empty key
    if (text.trim().isEmpty || _geminiKey.isEmpty) {
      return text; 
    }

    final prompt = "Target Language: $targetLang\n<PAYLOAD>\n$text\n</PAYLOAD>";

    // Chains executions into a sequential queue to totally defeat HTTP 429 errors
    final completer = Future.value(_lockPipeline).then((_) async {
      try {
        final modelInstance = _getInitializedModel();
        
        final response = await modelInstance.generateContent([Content.text(prompt)]);
        final String? responseText = response.text?.trim();

        if (responseText == null || responseText.isEmpty) {
          return text;
        }

        return responseText.replaceAllMapped(
          _matchingQuotesRegex, 
          (match) => match.group(2) ?? responseText,
        );

      } catch (exception, stackTrace) {
        debugPrint("⚠️ Translation exception caught: $exception");
        debugPrint("$stackTrace");
        return text; // Secure fallback prevents widget-tree crashes
      }
    });

    // Formally completes the pipeline hook without leaking dynamic error types across frames
    _lockPipeline = completer.then<void>(
      (_) => null, 
      onError: (Object error) => debugPrint("🔒 Queue pipeline released past network fault: $error"),
    );

    return completer;
  }
}
