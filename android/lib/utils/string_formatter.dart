class StringFormatter {
  // FIXED: Parameter is now nullable to safely intercept empty database entries without crashing
  static String clean(String? input) {
    if (input == null) return '';

    return input
        .trim()
        // FIXED: Uses an explicit Unicode-aware matching pattern to capture tabs, 
        // newlines, standard spaces, and non-breaking spaces (\u00A0) uniformly across Android, iOS, and Web.
        .replaceAll(RegExp(r'[\s\u00A0]+'), ' ');
  }

  /// Optional Helper: Safe truncation to prevent UI overflow bugs in long character grids
  static String truncate(String? input, int maxLength) {
    final cleaned = clean(input);
    if (cleaned.length <= maxLength) return cleaned;
    return '${cleaned.substring(0, maxLength)}...';
  }
}
