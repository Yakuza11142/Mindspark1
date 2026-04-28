class SsmlHumanizer {
  static String injectHumanBreathing(String rawText, String ahName) {
    // Adds microscopic pauses so the AI sounds like it is breathing in air
    String humanized = rawText.replaceAll(".", ". <break time='400ms'/>");
    humanized = humanized.replaceAll(",", ", <break time='200ms'/>");
    
    if (HologramName == "Spark") {
      // Spark sighs before explaining things
      return "<phoneme alphabet='ipa' ph='h'>huh</phoneme> <break time='500ms'/> $humanized";
    }
    
    return "<speak>$humanized</speak>";
  }
}