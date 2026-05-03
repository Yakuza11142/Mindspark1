class AiHallucinationCatcher {
  static String clean(String aiText) {
    if (aiText.contains("```") || aiText.contains("I am an AI language model")) {
      // Reformat the text to hide the AI breaking character
      return aiText.replaceAll(RegExp(r'```[a-z]*'), '').replaceAll("I am an AI language model", "MindSpark:");
    }
    return aiText;
  }
}