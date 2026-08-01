import 'package:flutter/foundation.dart';

/// Define a template for how any exam should be graded
abstract class GradingRule {
  String calculate(double percentage);
}

class UniversalGradingAlgorithm {
  // FIXED: Removed the immutable static constraint to allow your Supabase sync 
  // scripts to dynamically add or update grading rules at runtime.
  static final Map<String, GradingRule> _registry = {
    'SAT': SatGrading(),
    'GCSE': GcseGrading(),
    'JAMB': ScaledGrading(maxScore: 400),
    'JEE': ScaledGrading(maxScore: 300),
    'WAEC': WaecGrading(),
  };

  static String calculateScore(double percentage, String examCode) {
    final double p = percentage.clamp(0.0, 100.0);
    final String lookupKey = examCode.trim().toUpperCase();

    final rule = _registry[lookupKey];
    return rule != null ? rule.calculate(p) : "${p.toStringAsFixed(1)}%";
  }

  /// Public registration access to allow dynamic curriculum scaling injections from Supabase
  static void injectCustomGradingRule(String examCode, GradingRule dynamicRule) {
    _registry[examCode.trim().toUpperCase()] = dynamicRule;
    debugPrint("🎓 Custom grading strategy registered dynamically: [$examCode]");
  }
}

// --- REPAIRED SPECIFIC EXAM LOGIC ---

class SatGrading implements GradingRule {
  @override
  String calculate(double p) {
    // FIXED: Simulated sub-section scaling calculations. 
    // Both Math and Verbal are evaluated from a minimum baseline of 200 up to 800.
    final double halfPct = p / 100.0;
    
    final int mathSection = 200 + ((halfPct * 600) / 10).round() * 10;
    final int verbalSection = 200 + ((halfPct * 600) / 10).round() * 10;
    
    final int totalSat = (mathSection + verbalSection).clamp(400, 1600);
    return "$totalSat / 1600";
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
    // FIXED: Restored complete compliance with official WAEC alphanumeric grade tracking metrics.
    // Eliminates the dangerous 64% failure cliff by accounting for Credit and Pass tiers.
    if (p >= 75) return "A1 (Excellent)";   // 75% - 100% [1]
    if (p >= 70) return "B2 (Very Good)";   // 70% - 74% [1]
    if (p >= 65) return "B3 (Good)";        // 65% - 69% [1]
    if (p >= 60) return "C4 (Credit)";      // 60% - 64% [1]
    if (p >= 55) return "C5 (Credit)";      // 55% - 59% [1]
    if (p >= 50) return "C6 (Credit)";      // 50% - 54% [1]
    if (p >= 45) return "D7 (Pass)";        // 45% - 49% [1]
    if (p >= 40) return "E8 (Pass)";        // 40% - 44% [1]
    return "F9 (Fail)";                     // 0% - 39% [1]
  }
}
