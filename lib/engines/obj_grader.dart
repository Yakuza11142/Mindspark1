// lib/utils/grader_utils.dart

/// A global utility to grade any multiple-choice objective test
int gradeObjectives(List<String> studentAnswers, List<String> correctAnswers) {
  int score = 0;
  
  // Safety check: only iterate up to the smallest list size to prevent crashes
  final int totalToGrade = studentAnswers.length < correctAnswers.length 
      ? studentAnswers.length 
      : correctAnswers.length;

  for (int i = 0; i < totalToGrade; i++) {
    // Case-insensitive comparison
    if (studentAnswers[i].trim().toUpperCase() == correctAnswers[i].trim().toUpperCase()) {
      score++;
    }
  }
  return score;
}
