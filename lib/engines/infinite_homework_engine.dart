import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class InfiniteHomeworkEngine {
  late GenerativeModel _model;

  InfiniteHomeworkEngine() {
    _model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
  }

  Future<String> generateAssignment(String topic, int gradeLevel) async {
    final prompt = "Create a unique homework assignment for Grade $gradeLevel on '$topic'. Include 3 critical thinking questions and 1 creative task. Do not include answers.";
    
    try {
      final res = await _model.generateContent([Content.text(prompt)]);
      return res.text ?? "Error generating homework.";
    } catch (e) {
      return "Connection Error.";
    }
  }
}