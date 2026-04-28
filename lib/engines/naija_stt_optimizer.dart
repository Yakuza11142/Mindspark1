class NaijaSttOptimizer {
  static String fixTranscription(String rawSpeech) {
    String text = rawSpeech.toLowerCase();
    
    // Fix common Android Speech-to-Text mistakes for Nigerian accents
    text = text.replaceAll("jam", "JAMB");
    text = text.replaceAll("whack", "WAEC");
    text = text.replaceAll("fizzix", "physics");
    text = text.replaceAll("mass", "maths");
    text = text.replaceAll("kemi tree", "chemistry");
    text = text.replaceAll("o level", "O-Level");
    text = text.replaceAll("neko", "NECO");
    
    if (text.isEmpty) return "";
    return text[0].toUpperCase() + text.substring(1); // Capitalize first letter
  }
}