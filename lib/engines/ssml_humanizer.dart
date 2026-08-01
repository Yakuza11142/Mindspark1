class SsmlHumanizer {
  static String injectHumanBreathing(String rawText, String ahName) {
    // Escape the dot literal so it only matches periods
    String humanized = rawText.replaceAll("\$", "\\\$"); // Escape inner symbols if needed
    humanized = rawText.replaceAll(".", ". <break time='400ms'/>");
    humanized = humanized.replaceAll(",", ", <break time='200ms'/>");

    // Corrected to use RegExp.escape or literal split/join to avoid regex wildcard issues:
    humanized = rawText.split('.').join('. <break time=\'400ms\'/>');
    humanized = humanized.split(',').join(', <break time=\'200ms\'/>');

    // Fixed variable name and ensured valid root SSML tags
    if (ahName == "Spark") {
      return "<speak><phoneme alphabet='ipa' ph='h'>huh</phoneme> <break time='500ms'/> $humanized</speak>";
    }

    return "<speak>$humanized</speak>";
  }
}
