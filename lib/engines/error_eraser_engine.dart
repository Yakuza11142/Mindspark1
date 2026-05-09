import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class ErrorEraserEngine {
  late GenerativeModel _model;

  ErrorEraserEngine() {
    _model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
  }

  // INFINITE ERROR LOOP
  Future<Map<String, dynamic>> generateRemedialQuestion(String originalQuestion, String wrongAnswer, String topic) async {
    final prompt = """
    The student got this wrong.
    Topic: $topic
    Question: $originalQuestion
    Student Answered: $wrongAnswer
    
    1. Explain WHY they are wrong (be kind).
    2. Generate a NEW multiple-choice question testing the SAME concept but with different numbers or phrasing.
    
    Return JSON: {"explanation": "...", "new_question": "...", "options": ["A", "B", "C", "D"], "correct": "A"}
    """;

    try {
      final res = await _model.generateContent([Content.text(prompt)]);
      String clean = res.text!.replaceAll('```json', '').replaceAll('```', '');
      return jsonDecode(clean);
    } catch (e) {
      return {
        "explanation": "Let's try that again.",
        "new_question": originalQuestion, // Fallback to old question
        "options": ["Error", "Loading"],
        "correct": "Error"
      };
    }
  }
}