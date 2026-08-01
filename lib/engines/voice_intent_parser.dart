import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

class VoiceIntentParser {
  // Singleton pattern enforces a single unified tracking footprint across all view ports
  VoiceIntentParser._internal() {
    _loadDefaultSystemIntentProfiles();
  }
  static final VoiceIntentParser instance = VoiceIntentParser._internal();

  // Class properties isolated cleanly within the specific instance scope to prevent multi-threaded cross-talk
  final Map<String, RegExp> _compiledIntentRegistry = {};
  static const String defaultIntent = "LESSON_QUERY";

  /// Evaluates speech input strings branchlessly and returns the prioritized matched intent
  String determineIntent(String spokenText) {
    final String cleanedText = spokenText.trim().toLowerCase();
    if (cleanedText.isEmpty) return defaultIntent;

    // Formulate a local snapshot copy of the registry to prevent concurrent modification exceptions during scanning loops
    final Map<String, RegExp> activeRegistrySnapshot = Map<String, RegExp>.from(_compiledIntentRegistry);

    // Iterate through pre-compiled regex blocks instantly
    for (final MapEntry<String, RegExp> entry in activeRegistrySnapshot.entries) {
      if (entry.value.hasMatch(cleanedText)) {
        return entry.key;
      }
    }

    return defaultIntent;
  }

  /// Method to register new intents dynamically at runtime with strict word boundaries
  void registerIntent(String intentName, List<String> triggers) {
    final String cleanedIntent = intentName.trim().toUpperCase();
    if (cleanedIntent.isEmpty || triggers.isEmpty) return;

    // Maps words inside strict Regex Word Boundaries (\b) to completely eliminate substring collision traps
    final String escapedTriggers = triggers
        .map((t) => RegExp.escape(t.trim().toLowerCase()))
        .where((t) => t.isNotEmpty)
        .join('|');

    if (escapedTriggers.isEmpty) return;

    try {
      // Compiles the entire array of choices into a single unified tracking block
      _compiledIntentRegistry[cleanedIntent] = RegExp(
        '\\b($escapedTriggers)\\b',
        caseSensitive: false,
        multiLine: false,
      );
      developer.log("🛰️ VoiceIntentParser: Dynamic intent schema initialized safely: [$cleanedIntent]");
    } catch (e, stackTrace) {
      developer.log("❌ VoiceIntentParser: Failed to compile intent regex mapping loops", error: e, stackTrace: stackTrace);
    }
  }

  /// Private helper method that populates baseline configurations to ensure the parser never runs empty
  void _loadDefaultSystemIntentProfiles() {
    registerIntent("CANCEL", ["stop", "cancel", "no", "abort", "quit"]);
    registerIntent("HELP", ["help", "info", "explain", "tutorial"]);
  }

  /// Clear registry helper to allow clean workspace resets during hot-reloads safely
  void resetRegistry() {
    developer.log("⚙️ VoiceIntentParser: Purging active intent registry indices. Reverting to base definitions.");
    _compiledIntentRegistry.clear();
    _loadDefaultSystemIntentProfiles(); // Force immediate baseline re-population to block silent deadfalls
  }
}
