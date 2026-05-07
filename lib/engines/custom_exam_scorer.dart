import '../models/dynamic_exam_model.dart';

class CustomExamScorer {
  static String calculateScore(double percentage, DynamicExamModel exam) {
    if (exam.gradingStyle.toLowerCase().contains("band")) {
      // e.g. IELTS 1-9 band
      double band = (percentage / 100) * 9;
      return "Band ${band.toStringAsFixed(1)}";
    }
    // Default numerical score
    int actualScore = ((percentage / 100) * exam.maxScore).round();
    return "$actualScore / ${exam.maxScore}";
  }
}