class ExamScoringSystem {
  // Configurable weights for specific subjects
  static Map<String, double> subjectWeights = {
    'DEFAULT': 1.0, 
  };

  // Get weight for a specific subject or return default
  static double getWeight(String subject) {
    return subjectWeights[subject.toUpperCase()] ?? subjectWeights['DEFAULT']!;
  }

  /// Calculates total score for any list of subject results
  /// Example input: [{'name': 'Math', 'score': 45}, {'name': 'Art', 'score': 90}]
  static double calculateTotal(List<Map<String, dynamic>> results) {
    double grandTotal = 0;
    for (var item in results) {
      String name = item['name'] ?? '';
      num score = item['score'] ?? 0;
      grandTotal += (score * getWeight(name));
    }
    return grandTotal;
  }
}

void main() {
  // Example usage for any test
  var myExam = [
    {'name': 'Biology', 'score': 40},
    {'name': 'History', 'score': 35},
    {'name': 'Literature', 'score': 48},
  ];

  print('Final Score: ${ExamScoringSystem.calculateTotal(myExam)}');
}
