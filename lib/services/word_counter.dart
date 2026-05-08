class WordCounter {
  static int count(String text) {
    return text.trim().split(RegExp(r'\s+')).length;
  }
}