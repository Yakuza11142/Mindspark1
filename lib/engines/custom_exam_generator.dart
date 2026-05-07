import 'package:google_generative_ai/google_generative_ai.dart';

class CustomExamGenerator {
  // 1. Global Singleton Instance
  static final CustomExamGenerator _instance = CustomExamGenerator._internal();
  factory CustomExamGenerator() => _instance;
  CustomExamGenerator._internal();

  GenerativeModel? _model;

  // 2. Global Initialization (Call this once at App Startup)
  void init({required String apiKey, String modelName = 'gemini-1.5-pro'}) {
    _model = GenerativeModel(model: modelName, apiKey: apiKey);
  }

  // 3. Infinite Streaming Generation
  Stream<String> generateStream(String examName, List<String> subjects) async* {
    if (_model == null) throw Exception("Generator not initialized with API Key");

    // The prompt is engineered to handle "infinite" scale by requesting
    // a continuous stream of structured data.
    final prompt = """
      You are an Expert Examination Council System.
      Task: Generate a comprehensive, high-standard exam for $examName.
      Coverage: ${subjects.join(', ')}.
      Format: Output RAW JSON ONLY.
      Structure: An array of objects containing 'subject', 'question', 'options', and 'correct_answer'.
      Requirement: Ensure depth, rigor, and academic integrity.
    """;

    final responseStream = _model!.generateContentStream([Content.text(prompt)]);

    await for (final chunk in responseStream) {
      if (chunk.text != null) {
        yield chunk.text!; // Streams data to UI as it is generated
      }
    }
  }
}
