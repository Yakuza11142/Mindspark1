class DataSanitizer {
  static String cleanInput(String rawInput) {
    // Remove dangerous characters
    String clean = rawInput.replaceAll(RegExp(r'[<>/{}[\]~`]'), '');
    return clean.trim();
  }
}