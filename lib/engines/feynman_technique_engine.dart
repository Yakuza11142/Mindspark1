import 'package:google_generative_ai/google_generative_ai.dart';

class FeynmanEngine {
  // 1. Global Singleton Instance
  static final FeynmanEngine _instance = FeynmanEngine._internal();
  factory FeynmanEngine() => _instance;
  FeynmanEngine._internal();

  GenerativeModel? _model;

  // 2. Global Initialization (Call once in main.dart)
  void init({required String apiKey, String modelName = 'gemini-1.5-pro'}) {
    _model = GenerativeModel(model: modelName, apiKey: apiKey);
  }

  /// 3. Infinite Clarity Audit (Streaming)
  /// Evaluates complex topics for logical gaps and jargon.
  Stream<String> evaluateStream(String topic, String explanation) async* {
    if (_model == null) throw Exception("FeynmanEngine not initialized.");

    final prompt = """
      Role: Professional Logic & Clarity Auditor.
      Task: Evaluate the following explanation of "$topic" using the Feynman Technique.
      
      Explanation: "$explanation"
      
      Criteria:
      1. Clarity Score (out of 10).
      2. Jargon Detection: Identify complex terms that lack clear definitions.
      3. Logical Gaps: Point out where the flow of reasoning breaks down.
      4. Refined Summary: Provide a 1-sentence version of the explanation that is impossible to misunderstand.
      
      Tone: Institutional, precise, and constructive.
    """;

    final responseStream = _model!.generateContentStream([Content.text(prompt)]);

    await for (final chunk in responseStream) {
      if (chunk.text != null) yield chunk.text!;
    }
  }
}
