import 'package:flutter/material.dart';

class StringFormatter {
  /// Cleans redundant horizontal spaces universally across Web/Native while protecting code indentations and paragraphs
  static String clean(String? input) {
    if (input == null) return '';

    // Step 1: Prevent vertical layout bloat by collapsing 3+ sequential line breaks down to 2
    final normalizedNewlines = input.replaceAll(RegExp(r'\n{3,}'), '\n\n');

    return normalizedNewlines
        .split('\n') 
        .map((line) {
          // Removes trailing spaces while keeping your left-side indentations locked
          final trailingCleaned = line.replaceAll(RegExp(r'[ \t\u00A0\u2000-\u200A]+$'), '');
          
          // FIXED: Extracted leading indentation to support lookbehind-free web platforms natively
          final leadingMatch = RegExp(r'^[ \t\u00A0\u2000-\u200A]*').stringMatch(trailingCleaned) ?? '';
          final contentPart = trailingCleaned.substring(leadingMatch.length);

          // FIXED: Safely condenses spaces inside line bodies without altering the leading indentation blocks
          final condensedContent = contentPart.replaceAll(RegExp(r'[ \t\u00A0\u2000-\u200A]+'), ' ');
          
          return '$leadingMatch$condensedContent';
        })
        .join('\n') 
        .trim();
  }

  /// Truncates string contents safely by counting visual character clusters instead of raw surrogate code units
  static String truncate(String? input, int maxLength) {
    final cleaned = clean(input);
    
    if (maxLength <= 0) return '...';
    
    final graphemeClusters = cleaned.characters;
    if (graphemeClusters.length <= maxLength) return cleaned;

    try {
      final truncatedText = graphemeClusters.take(maxLength).toString();
      return '${truncatedText.trimRight()}...';
    } catch (_) {
      return '...'; 
    }
  }
}
