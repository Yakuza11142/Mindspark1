class GlobalLanguageModel {
  /// Injects translation instructions for ANY target language globally.
  /// Handles the context of technical terms that may not exist in the target language.
  static String injectLanguage(String basePrompt, String targetLanguage) {
    // Standardizing check: If target is the default/base, return prompt as is.
    if (targetLanguage.toLowerCase() == "english") return basePrompt;
    
    return """
$basePrompt

[CRITICAL GLOBAL INSTRUCTION: 
1. Translate the entire response into flawless $targetLanguage.
2. For specialized scientific, mathematical, or technical terms without a direct $targetLanguage equivalent, do not leave them in English; instead, explain the concept descriptively within the $targetLanguage translation to ensure full user understanding.]
    """;
  }
}
