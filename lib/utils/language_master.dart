import 'package:flutter/material.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:google_translate_api/google_translate_api.dart';

class LanguageMaster {
  // Configured as a standard instance to allow proper lifecycle resource closing
  final _identifier = LanguageIdentifier(confidenceThreshold: 0.5);

  Future<String> identifyLanguage(String text) async {
    try {
      // Returns language codes (e.g., 'en', 'fr', 'es', 'yo' for Yoruba, 'ig' for Igbo, 'ha' for Hausa)
      final String languageCode = await _identifier.identifyLanguage(text);
      return languageCode;
    } catch (e) {
      return "und"; // Undetermined
    }
  }

  // CRUCIAL: Native C++ memory channels must be freed up when the app switches states
  void dispose() {
    _identifier.close();
  }
}

class UniversalTranslator {
  // CRUCIAL: Read keys safely using global String definitions or environment values. 
  // DO NOT leave active raw keys inside comments or hardcoded strings.
  static final _api = GoogleTranslate(
    const String.fromEnvironment('GOOGLE_API_KEY', defaultValue: 'FALLBACK_KEY')
  );

  static Future<String> translateToEnglish(String text) async {
    try {
      final translation = await _api.translate(
        text: text,
        targetLang: 'en', // Automatically converts foreign input strings directly to English
      );
      return translation;
    } catch (e) {
      return text; // Graceful fallback to original text if translation pipeline fails offline
    }
  }
}

// Fixed top-level handler orchestration
void onUserMessage(String userInput) async {
  final languageMaster = LanguageMaster();
  
  // 1. Detect the incoming language
  String lang = await languageMaster.identifyLanguage(userInput);

  // 2. If it is not English or Undetermined, process the translation pipeline
  if (lang != 'en' && lang != 'und') {
    debugPrint("Spark detected a non-English language: $lang");
    String translated = await UniversalTranslator.translateToEnglish(userInput);

    // Spark processes the unified English translation payload cleanly
    debugPrint("Spark says: 'I see you're speaking $lang. In English, that's: $translated'");
  }

  // Clean up native ML Kit resources immediately after inference execution
  languageMaster.dispose();
}
