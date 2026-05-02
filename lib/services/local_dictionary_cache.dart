class LocalDictionaryCache {
  static const Map<String, String> jambHotWords = {
    "abundant": "plentiful (Synonym), scarce (Antonym)",
    "lucid": "clear, transparent",
    "ephemeral": "short-lived, fleeting",
    "obsolete": "outdated, no longer in use"
  };

  static String lookup(String word) {
    return jambHotWords[word.toLowerCase()] ?? "Word not in offline cache. Connect to internet for full AI definition.";
  }
}