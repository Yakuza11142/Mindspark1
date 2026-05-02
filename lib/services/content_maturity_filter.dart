class ContentMaturityFilter {
  static String filterVisualPrompt(String prompt, String lifeStage) {
    if (lifeStage == "JUNIOR") {
      return "$prompt. Make it cartoonish, kid-friendly, colorful, and completely safe for children. No scary imagery.";
    }
    return "$prompt. Hyper-realistic, scientific, highly detailed.";
  }
}