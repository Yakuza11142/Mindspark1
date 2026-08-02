class StringCleaner {
  static String clean(String? input) {
    // Returns an empty string if input is null, otherwise strips characters in one pass
    return input?.replaceAll(RegExp(r'[*#`]'), '') ?? '';
  }
}
