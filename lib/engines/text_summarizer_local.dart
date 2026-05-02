class TextSummarizerLocal {
  static String getSummary(String fullText) {
    List<String> sentences = fullText.split('.');
    if (sentences.length > 2) {
      return "${sentences[0]}. ${sentences[1]}.";
    }
    return fullText;
  }
}