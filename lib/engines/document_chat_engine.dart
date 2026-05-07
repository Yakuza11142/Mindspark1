import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class DocumentChatEngine {
  late GenerativeModel _model;
  String documentContext = "";

  DocumentChatEngine() {
    _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: Secrets.geminiKey);
  }

  void loadDocument(String extractedText) {
    // Compress text if too large, then store in memory
    documentContext = "CONTEXT DOCUMENT: $extractedText\n\n";
  }

  Future<String> askDocument(String question) async {
    if (documentContext.isEmpty) return "Please upload a document first.";
    
    final prompt = "$documentContext Answer the following question based ONLY on the document above: '$question'";
    try {
      final res = await _model.generateContent([Content.text(prompt)]);
      return res.text ?? "I could not find the answer in the document.";
    } catch (e) {
      return "Document is too large or network error.";
    }
  }
}