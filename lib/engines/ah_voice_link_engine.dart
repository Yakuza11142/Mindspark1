import 'package:speech_to_text/speech_to_text.dart';
import 'naija_stt_optimizer.dart';
import '../engines/groq_api_service.dart';
import '../services/elevenlabs_ah_voice.dart';
import '../models/ai_persona.dart';

class AhVoiceLinkEngine {
  static final SpeechToText _speech = SpeechToText();
  
  static Future<void> startListening(Function(String) onTextHeard, Function(String) onAiReply, AiPersona persona) async {
    bool available = await _speech.initialize();
    if (available) {
      _speech.listen(
        localeId: 'en_NG', // Nigerian English Locale
        onResult: (result) async {
          if (result.finalResult) {
            // 1. Get what the user said and fix the accent typos
            String userSaid = NaijaSttOptimizer.fixTranscription(result.recognizedWords);
            onTextHeard(userSaid);
            
            // 2. Send to Groq LPU (Hyper-fast AI)
            String prompt = "${persona.systemPrompt}\nUser says: $userSaid";
            String aiAnswer = await GroqApiService.askGroq(prompt, "llama3-8b-8192");
            
            // 3. Make ElevenLabs speak the answer
            ElevenLabsAhVoice.speakLikeHuman(aiAnswer, persona.voiceId); // Voice ID added to Persona Model
            onAiReply(aiAnswer);
          }
        }
      );
    }
  }

  static void stopListening() {
    _speech.stop();
  }
}