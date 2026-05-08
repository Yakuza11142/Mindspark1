import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class SocraticEngine {
  late GenerativeModel _model;

  SocraticEngine() {
    _model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
  }

  Future<String> guideStudent(String topic, String userQuestion) async {
    final prompt = """
    You are a Socratic Tutor. The student asks about: '$userQuestion' regarding '$topic'.
    DO NOT give the direct answer.
    Instead, ask a guiding question that helps them figure it out themselves.
    Be encouraging.
    """;
    
    try {
      final res = await _model.generateContent([Content.text(prompt)]);
      return res.text ?? "Let's think about this together.";
    } catch (e) {
      return "What do you think the answer is?";
    }
  }
}