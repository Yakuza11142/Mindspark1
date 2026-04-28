class ElevenLabsLanguageMapper {
  static String getModelForLanguage(String languageName) {
    if (languageName == "English" || languageName == "Nigerian Pidgin") {
      return "eleven_monolingual_v1"; // Standard
    }
    // For French, Mandarin, etc., use the Multilingual model
    return "eleven_multilingual_v2";
  }
}