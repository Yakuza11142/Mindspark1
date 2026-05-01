class LocalSearchIndexer {
  static final Map<String, String> _index = {}; // Ram-based index

  static void buildIndex(Map<String, String> localDatabase) {
    localDatabase.forEach((key, value) {
      _index[key.toLowerCase()] = value;
    });
    print("⚡ Fast-Index Built in RAM.");
  }

  static String? search(String query) {
    return _index[query.toLowerCase()];
  }
}