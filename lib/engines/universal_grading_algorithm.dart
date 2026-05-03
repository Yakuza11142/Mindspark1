/// Define a template for how any exam should be graded
abstract class GradingRule {
  String calculate(double percentage);
}

class UniversalGradingAlgorithm {
  /// The "Infinite" Registry: Add new exams here or load them from a database
  static final Map<String, GradingRule> _registry = {
    'SAT': SatGrading(),
    'GCSE': GcseGrading(),
    'JAMB': ScaledGrading(maxScore: 400),
    'JEE': ScaledGrading(maxScore: 300),
    'WAEC': WaecGrading(), // Easy to add more
  };

  static String calculateScore(double percentage, String examCode) {
    double p = percentage.clamp(0.0, 100.0);
    
    // Look up the exam in the registry
    final rule = _registry[examCode.toUpperCase()];

    // If it exists, use its logic; otherwise, default to percentage
    return rule != null ? rule.calculate(p) : "${p.toStringAsFixed(1)}%";
  }
}

// --- SPECIFIC EXAM LOGIC ---

class SatGrading implements GradingRule {
  @override
  String calculate(double p) {
    int satScore = 400 + ((p / 100) * 1200).round();
    return "${(satScore ~/ 10) * 10} / 1600";
  }
}

class GcseGrading implements GradingRule {
  @override
  String calculate(double p) {
    if (p >= 90) return "Grade 9 (A**)";
    if (p >= 80) return "Grade 8 (A*)";
    if (p >= 70) return "Grade 7 (A)";
    if (p >= 60) return "Grade 6 (B)";
    if (p >= 50) return "Grade 5 (Strong C)";
    if (p >= 40) return "Grade 4 (Standard C)";
    return "Grade U (Fail)";
  }
}

class ScaledGrading implements GradingRule {
  final int maxScore;
  ScaledGrading({required this.maxScore});

  @override
  String calculate(double p) => "${((p / 100) * maxScore).round()} / $maxScore";
}

class WaecGrading implements GradingRule {
  @override
  String calculate(double p) {
    if (p >= 75) return "A1 (Excellent)";
    if (p >= 70) return "B2 (Very Good)";
    if (p >= 65) return "B3 (Good)";
    return "F9 (Fail)";
  }
}
