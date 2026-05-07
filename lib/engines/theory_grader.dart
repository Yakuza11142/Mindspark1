import 'package:google_generative_ai/google_generative_ai.dart';

class WaecTheoryGrader {
  static Future<String> gradeTheory({
    required String apiKey,
    required String question,
    required String studentAnswer,
    String modelName = 'gemini-1.5-flash',
    int maxMarks = 10,
  }) async {
    final model = GenerativeModel(model: modelName, apiKey: apiKey);
    final prompt = """
    You are a strict teacher marking WAEC theory questions.
    Question: $question
    Student Answer: $studentAnswer
    Grade this out of $maxMarks marks.
    Provide a score and point out missing keywords required by the standard marking scheme.
    """;
    try {
      final res = await model.generateContent([Content.text(prompt)]);
      return res.text ?? "Error grading.";
    } catch (e) {
      return "Network or API Error: $e";
    }
  }
}
