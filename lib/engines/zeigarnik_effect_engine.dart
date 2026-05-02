class ZeigarnikEffectEngine {
  static bool shouldInterruptLesson(int contentProgressPercentage) {
    // Interrupt the user right before the end to cement memory
    return contentProgressPercentage == 90;
  }
  
  static String getCliffhangerPrompt() {
    return "Before I reveal the final answer, based on what we just discussed, what do YOU think happens next?";
  }
}