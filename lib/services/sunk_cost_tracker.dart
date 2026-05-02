import 'package:shared_preferences/shared_preferences.dart';

class SunkCostTracker {
  /// Call this whenever a question is answered to increment the "Sunk Cost"
  static Future<void> incrementProgress() async {
    final prefs = await SharedPreferences.getInstance();
    
    // 1. Increment total questions
    int currentQuestions = prefs.getInt('total_questions_answered') ?? 0;
    await prefs.setInt('total_questions_answered', currentQuestions + 1);

    // 2. Set the "Infinite Start Date" if it doesn't exist
    if (prefs.getInt('first_launch_timestamp') == null) {
      await prefs.setInt('first_launch_timestamp', DateTime.now().millisecondsSinceEpoch);
    }
  }

  static Future<String> getInvestmentSummary() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Calculate Days Active infinitely based on the start date
    int firstLaunch = prefs.getInt('first_launch_timestamp') ?? DateTime.now().millisecondsSinceEpoch;
    int now = DateTime.now().millisecondsSinceEpoch;
    
    // Difference in days (minimum 1)
    int daysActive = DateTime.fromMillisecondsSinceEpoch(now)
        .difference(DateTime.fromMillisecondsSinceEpoch(firstLaunch))
        .inDays;
    if (daysActive == 0) daysActive = 1;

    int totalQuestions = prefs.getInt('total_questions_answered') ?? 0;
    
    // The "Naija Uncle" or Strict Coach flavor of persuasion
    return "You have studied with MindSpark for $daysActive days and answered $totalQuestions questions. You are in the top 15% of dedicated students. Don't stop now!";
  }
}
static Future<String> getInvestmentSummary() async {
  final prefs = await SharedPreferences.getInstance();
  int totalQuestions = prefs.getInt('total_questions_answered') ?? 0;
  int daysActive = prefs.getInt('total_active_days') ?? 1;

  // This formula makes the % smaller (better) as totalQuestions grows
  // For every 20 questions, they move up roughly 1%
  double dynamicRank = 30.0 - (totalQuestions / 20.0);
  
  // Clamp it so it stays between 1% and 30%
  double finalRank = dynamicRank.clamp(1.0, 30.0);

  return "You've been here $daysActive days and answered $totalQuestions questions. "
         "You are now in the top ${finalRank.toStringAsFixed(1)}% of students. "
         "Don't waste that effort now!";
}
