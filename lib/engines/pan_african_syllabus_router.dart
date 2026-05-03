class PanAfricanSyllabusRouter {
  // A global registry of educational standards
  static const Map<String, String> _syllabusRegistry = {
    'NG': "NERDC / JAMB / WAEC Syllabus",
    'GH': "GES / WASSCE Syllabus",
    'KE': "8-4-4 / KCSE Syllabus",
    'ZA': "CAPS / Matric Syllabus",
    'UG': "UNEB Syllabus",
    'TZ': "NECTA Syllabus",
    'RW': "REB Syllabus",
    'US': "Common Core / AP Standards",
    'GB': "UK National Curriculum / GCSE",
    'IN': "CBSE / ICSE Syllabus",
  };

  /// Returns the specific syllabus for ANY country code.
  /// Defaults to Cambridge IGCSE for unsupported regions.
  static String getSyllabusContext(String countryCode) {
    return _syllabusRegistry[countryCode.toUpperCase()] ?? "Cambridge IGCSE Syllabus";
  }
}
