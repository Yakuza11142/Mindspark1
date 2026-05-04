class OfflineVoiceGrammarFixer {
  // A dynamic registry for phonetic corrections and acronyms
  static final Map<String, String> _correctionMap = {};

  static String fix(String rawText) {
    if (rawText.isEmpty) return rawText;
    
    String text = rawText.toLowerCase();

    // Apply all registered global corrections
    _correctionMap.forEach((misspelling, correction) {
      text = text.replaceAll(misspelling.toLowerCase(), correction);
    });

    // Global capitalization: Capitalize first letter of the final string
    return text[0].toUpperCase() + text.substring(1);
  }

  // Method to inject global rules (e.g., from a database or JSON)
  static void registerRules(Map<String, String> rules) {
    _correctionMap.addAll(rules);
  }
}
