class ContextualFolkloreInjector {
  // Global registry using a unique key combination of Language and Topic
  static const Map<String, String> _mythologyRegistry = {
    'Yoruba_electricity': "Relate the concept of electrical currents and voltage to the mythology of Sango, the God of Thunder, to make it culturally memorable.",
    'Igbo_electricity': "Relate the concept of lightning and energy to Amadioha to make it culturally memorable.",
  };

  /// Globally applies mythology by looking up the combined key of language and topic.
  static String applyMythology(String topic, String language) {
    final String lookupKey = "${language}_${topic.toLowerCase().trim()}";
    
    return _mythologyRegistry[lookupKey] ?? "Explain using standard local examples.";
  }
}
