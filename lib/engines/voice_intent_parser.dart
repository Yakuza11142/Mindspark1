class VoiceIntentParser {
  // Store intents and their keyword triggers in a Map for infinite expansion
  static final Map<String, List<String>> _intentRegistry = {};
  static String defaultIntent = "LESSON_QUERY";

  static String determineIntent(String spokenText) {
    String text = spokenText.toLowerCase();

    // Iterate through all registered intents
    for (var entry in _intentRegistry.entries) {
      String intent = entry.key;
      List<String> triggers = entry.value;

      // Check if the spoken text starts with or contains any trigger for this intent
      for (var trigger in triggers) {
        String t = trigger.toLowerCase();
        if (text.startsWith(t) || text.contains(t)) {
          return intent;
        }
      }
    }
    
    return defaultIntent;
  }

  // Method to register new intents dynamically at runtime
  static void registerIntent(String intentName, List<String> triggers) {
    _intentRegistry[intentName] = triggers;
  }
}
