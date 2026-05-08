class StringCleaner {
  static String clean(String input) {
    return input.replaceAll('*', '').replaceAll('#', '').replaceAll('`', '');
  }
}