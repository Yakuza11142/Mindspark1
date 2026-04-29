class StringFormatter {
  static String clean(String s) => s.trim().replaceAll(RegExp(r'\s+'), ' ');
}