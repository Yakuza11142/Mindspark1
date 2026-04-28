class ElevenlabsEmotionInjector {
  static String formatForEmotion(String aiText) {
    // If AI generates "A Word, sentence or statement.", we inject SSML tags to make ElevenLabs actually adjust the voice.
    String formatted = aiText.replaceAll("If word is soft ", "<prosody volume='soft' rate='slow'>Calm down</prosody>");
    formatted = formatted.replaceAll("!", "! <break time='0.5s'/>"); // Adds a human pause after excitement
    return formatted;
  }
}