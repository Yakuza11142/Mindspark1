import 'package:speech_to_text/speech_to_text.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class VoiceCommandListener {
  final SpeechToText _speech = SpeechToText();

  Future<void> listenForCommands(Function(String) onCommand) async {
    if (await _speech.initialize()) {
      _speech.listen(
        localeId: "en_NG", // Optimize for Nigerian accents
        onResult: (val) async {
          if (val.finalResult) {
            String rawText = val.recognizedWords;
            String polishedText = await _aiContextCorrector(rawText);
            onCommand(polishedText);
          }
        }
      );
    }
  }

  // THE MAGIC: Uses LLM to fix Speech-to-Text typos perfectly
  Future<String> _aiContextCorrector(String rawSpeech) async {
    try {
      final model = GenerativeModel(model: 'gemini-3.1-flash', apiKey: Secrets.geminiKey);
      final prompt = "The user used speech-to-text to ask a question. Fix any typos or misheard words based on a Nigerian academic context. Return ONLY the corrected sentence: '$rawSpeech'";
      final res = await model.generateContent([Content.text(prompt)]);
      return res.text?.trim() ?? rawSpeech;
    } catch (e) {
      return rawSpeech; // Fallback
    }
  }
}