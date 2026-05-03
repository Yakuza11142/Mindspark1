class ScholarshipAiMatcher {
  static List<String> findScholarships(int jambScore) {
    if (jambScore > 300) {
      return["MTN Foundation Scholarship", "PTDF Overseas Scholarship", "Shell Nigeria University Grant"];
    }
    return["Keep studying to unlock Scholarship Matches!"];
  }
}