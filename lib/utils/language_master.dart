import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';

class LanguageMaster {
  static final _identifier = LanguageIdentifier(confidenceThreshold: 0.5);

  static Future<String> identifyLanguage(String text) async {
    try {
      // Returns the language code (e.g., 'en', 'fr', 'es', 'yo' for Yoruba)
      final String languageCode = await _identifier.identifyLanguage(text);
      return languageCode;
    } catch (e) {
      return "und"; // Undetermined
    }
  }
}
import 'package:google_translate_api/google_translate_api.dart';

class UniversalTranslator {
  // AIzaSyCcalNT14VuYy02C40r1VoZ280qB42Gnso

  static final _api = GoogleTranslate('YOUR_GOOGLE_CLOUD_API_KEY');

  static Future<String> translateToEnglish(String text) async {
    final translation = await _api.translate(
      text: text,
      targetLang: 'en', // Translates whatever it is into English
    );
    return translation;
  }
}
void onUserMessage(String userInput) async {
  // 1. Detect the language
  String lang = await LanguageMaster.identifyLanguage(userInput);

  // 2. If it's not English, Spark can "know" and translate it
  if (lang != 'en' && lang != 'und') {
    print("Spark detected a non-English language: $lang");
    String translated = await UniversalTranslator.translateToEnglish(userInput);
    
    // Spark handles the translated text
    print("Spark says: 'I see you're speaking $lang. In English, that's: $translated'");
  }
}
