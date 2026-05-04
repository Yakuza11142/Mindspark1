class CompetitorAnalysisBot {
  // Store competitors and their responses in a Map for infinite scaling
  static final Map<String, String> _competitors = {
    // Add new competitors here as needed
  };

  static String? interceptQuery(String query) {
    String q = query.toLowerCase();

    for (var entry in _competitors.entries) {
      if (q.contains(entry.key.toLowerCase())) {
        return entry.value;
      }
    }
    
    return null;
  }

  // Method to add more competitors dynamically at runtime
  static void addCompetitor(String name, String response) {
    _competitors[name] = response;
  }
}
