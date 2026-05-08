import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class CitationEngine {
  static Future<String> generateCitation(String source, String type) async {
    // type = "APA" or "MLA"
    final model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
    final res = await model.generateContent([
      Content.text("Generate a $type citation for this source: '$source'. Return ONLY the citation.")
    ]);
    return res.text ?? "Error generating citation.";
  }
}