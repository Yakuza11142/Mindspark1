import '../data/global_exam_database.dart';

class GlobalGradingSystem {
  static String formatScore(double percentage, String examName) {
    var exam = GlobalExamDatabase.getExam(examName);
    int max = exam['maxScore'];

    if (examName == "GCSE") {
      // Special 1-9 grading scale for UK
      if (percentage >= 90) return "Grade 9";
      if (percentage >= 80) return "Grade 8";
      if (percentage >= 70) return "Grade 7";
      if (percentage >= 60) return "Grade 6";
      return "Grade U";
    }

    int actualScore = ((percentage / 100) * max).round();
    return "$actualScore / $max";
  }
}