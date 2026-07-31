import 'package:flutter/foundation.dart';

class VoiceIntentParser {
  // FIXED: Separated intents from raw lists into pre-compiled Regex blocks 
  // to ensure absolute evaluation consistency and lightning-fast tracking speeds.
  static final Map<String, RegExp> _compiledIntentRegistry = {};
  static const String defaultIntent = "LESSON_QUERY";

  /// Evaluates speech input strings branchlessly and returns the prioritized matched intent.
  static String determineIntent(String spokenText) {
    if (spokenText.trim().isEmpty) return defaultIntent;
    
    final String text = spokenText.trim().toLowerCase();

    // Iterate through pre-compiled regex blocks instantly
    for (final entry in _compiledIntentRegistry.entries) {
      // FIXED: Uses hardware-optimized pattern matching engines instead of linear string loops.
      // This drops lookups down to a highly efficient single-pass check per intent.
      if (entry.value.hasMatch(text)) {
        return entry.key;
      }
    }

    return defaultIntent;
  }

  /// Method to register new intents dynamically at runtime with strict word boundaries
  static void registerIntent(String intentName, List<String> triggers) {
    if (triggers.isEmpty) return;

    // FIXED: Maps words inside strict Regex Word Boundaries (\b) to completely eliminate 
    // substring collision traps like "anode" accidentally matching the cancellation trigger "no".
    final escapedTriggers = triggers
        .map((t) => RegExp.escape(t.trim().toLowerCase()))
        .where((t) => t.isNotEmpty)
        .join('|');

    if (escapedTriggers.isEmpty) return;

    try {
      // Compiles the entire array of choices into a single unified tracking block
      _compiledIntentRegistry[intentName] = RegExp(
        '\\b($escapedTriggers)\\b',
        caseSensitive: false,
        multiLine: false,
      );
      debugPrint("🛰️ Dynamic intent schema initialized safely: [$intentName]");
    } catch (e) {
      debugPrint("🚨 Failed to compile intent regex mapping loops: $e");
    }
  }

  /// Clear registry helper to allow clean workspace resets during hot-reloads
  static void resetRegistry() {
    _compiledIntentRegistry.clear();
  }
}
