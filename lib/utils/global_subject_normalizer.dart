class GlobalSubjectNormalizer {
  // Add as many keywords as you want here
  static const Map<String, List<String>> _rules = {
    "English Language": ["use of english", "language arts", "literacy", "grammar"],
    "Advanced Mathematics": ["further math", "calculus", "pure math", "additional math"],
    "Political Science": ["civic", "government", "social studies", "citizenship"],
    "Biological Sciences": ["biology", "botany", "zoology", "anatomy"],
    "Physics": ["applied physics", "mechanics", "thermodynamics"],
  };

  static String normalize(String localSubjectName) {
    String lower = localSubjectName.toLowerCase().trim();

    for (var entry in _rules.entries) {
      String officialName = entry.key;
      List<String> keywords = entry.value;

      // Checks if the input matches any keyword in the list
      if (keywords.any((k) => lower.contains(k))) {
        return officialName;
      }
    }

    // If no match found, return original name capitalized
    return localSubjectName[0].toUpperCase() + localSubjectName.substring(1);
  }
}
static Future<String> normalizeFromCloud(String localName) async {
  final response = await supabase
      .from('subject_normalization')
      .select('official_name')
      .ilike('keyword', '%$localName%')
      .maybeSingle();

  return response?['official_name'] ?? localName;
}
