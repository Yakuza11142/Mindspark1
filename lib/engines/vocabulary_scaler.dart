class VocabularyScaler {
  static String injectLexileLevel(String prompt, String stage) {
    if (stage == "JUNIOR") return "$prompt [Keep Lexile reading measure below 600L. No big words.]";
    return prompt;
  }
}