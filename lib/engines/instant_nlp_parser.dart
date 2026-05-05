String extractKeyword(String sentence) {
  List<String> words = sentence.trim().split(" ");
  return words.isNotEmpty ? words.last : "";
}
