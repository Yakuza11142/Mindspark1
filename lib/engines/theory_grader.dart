import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class WaecTheoryGrader {
  static Future<String> gradeTheory(String question, String studentAnswer) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
    final prompt = """
    You are a strict Teacher. 
    Question: $question
    Student Answer: $studentAnswer
    Grade this out of 10 marks. Point out missing keywords required by the standard marking scheme.
    """;
    
    try {
      final res = await model.generateContent([Content.text(prompt)]);
      return res.text ?? "Error grading.";
    } catch (e) {
      return "Network Error.";
    }
  }
}