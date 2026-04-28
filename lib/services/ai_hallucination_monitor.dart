class AiHallucinationMonitor {
  static String sanitizeOutput(String aiResponse) {
    // If the AI accidentally breaks character and says "As an AI..."
    String clean = aiResponse.replaceAll("As an AI language model,", "");
    clean = clean.replaceAll("I am a large language model", "I am MindSpark");
    return clean.trim();
  }
}