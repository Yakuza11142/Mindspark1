class EmotionalAdaptationEngine {
  static String adjustPrompt(String basePrompt, bool isFrustrated) {
    if (isFrustrated) {
      return "$basePrompt[SYSTEM: The user seems tired or frustrated. Drastically simplify the answer. Use extreme encouragement. Add a joke.]";
    }
    return basePrompt;
  }
}