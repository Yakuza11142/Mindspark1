class ExamContextInjector {
  /// 1. The Core Knowledge Base (The "Knowns")
  static const Map<String, String> _globalKnowledge = {
    "SAT": "US College Board standards, algebraic reasoning, and US Imperial units.",
    "GCSE": "UK AQA/Edexcel marking schemes and British English conventions.",
    "JEE": "Indian IIT standards, high-level numerical Physics and Chemistry.",
    "JAMB": "Nigerian UTME/NERDC syllabus with direct objective logic.",
    "GAOKAO": "Chinese National Entrance standards, deep analytical complexity.",
    "WAEC": "West African WASSCE standards, structured essay and objective formats.",
    "MCAT": "Medical College Admission standards, biological and biochemical foundations.",
  };

  /// 2. The Universal Injector
  static String buildSystemPrompt(String examCode) {
    final code = examCode.toUpperCase().trim();

    // Check if we have a specific high-quality prompt for this exam
    if (_globalKnowledge.containsKey(code)) {
      return "Context: ${_globalKnowledge[code]}";
    }

    // 3. The "Infinite" Logic: Guess context based on naming patterns
    return _inferContext(code);
  }

  static String _inferContext(String code) {
    // If the code contains "US", "UK", "IN", etc.
    if (code.contains("US")) return "Context: United States Educational Standards for $code.";
    if (code.contains("UK")) return "Context: United Kingdom Curriculum and British English for $code.";
    if (code.contains("NG")) return "Context: Nigerian National Curriculum (NERDC) for $code.";
    
    // Fallback for any unknown exam (The Global Default)
    return "Context: Standard International Academic Curriculum for $code. "
           "Focus on accuracy, step-by-step reasoning, and syllabus-specific terminology.";
  }
}
