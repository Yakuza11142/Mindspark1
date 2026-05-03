class MarkdownLatexFormatter {
  static String formatAiMathOutput(String rawText) {
    // Replaces standard AI block math \[ ... \] with inline math \( ... \) for cleaner UI rendering
    String formatted = rawText.replaceAll(RegExp(r'\\\['), r'\(');
    formatted = formatted.replaceAll(RegExp(r'\\\]'), r'\)');
    
    // Cleans up stray markdown bold tags around equations
    formatted = formatted.replaceAll(RegExp(r'\*\*\\'), r'\\');
    formatted = formatted.replaceAll(RegExp(r'\\\*\*'), r'\\');
    
    return formatted.trim();
  }
}