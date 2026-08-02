class MarkdownLatexFormatter {
  static String formatAiMathOutput(String rawText) {
    if (rawText.isEmpty) return "";

    // 1. Converts AI Block Math \[ ... \] to standard $$ ... $$ for proper Markdown LaTeX blocks
    String formatted = rawText.replaceAll(RegExp(r'\\\['), r'$$');
    formatted = formatted.replaceAll(RegExp(r'\\\]'), r'$$');

    // 2. Converts AI Inline Math \( ... \) to standard $ ... $ if your parser needs clean strings
    formatted = formatted.replaceAll(RegExp(r'\\\('), r'$');
    formatted = formatted.replaceAll(RegExp(r'\\\)'), r'$');

    // 3. SAFELY cleans markdown bold tags formatting surrounding LaTeX equations (**$equation$**)
    // This looks for bold markdown explicitly nesting a LaTeX dollar sign or backslash
    formatted = formatted.replaceAll(RegExp(r'\*\*(?=\$|\Q\\\E)'), '');
    formatted = formatted.replaceAll(RegExp(r'(?<=\$|\Q\\\E)\*\*'), '');

    return formatted.trim();
  }
}
