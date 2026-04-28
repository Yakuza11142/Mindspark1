import 'package:speech_to_text/speech_to_text.dart';
import '../services/audio_service.dart';
import 'spark_ai_core.dart'; // Your LLM

class TwoWayVoiceEngine {
  static final SpeechToText _stt = SpeechToText();
  static bool _isConversing = false;

  static Future<void> startConversation(String persona, bool isPro) async {
    _isConversing = true;
    print("🎙️ Two-Way Audio Link Established with $persona");

    if (await _stt.initialize()) {
      _listenAndRespond(persona, isPro);
    }
  }

  static void _listenAndRespond(String persona, bool isPro) {
    if (!_isConversing) return;
    
    _stt.listen(onResult: (result) async {
      if (result.finalResult) {
        String userSpoke = result.recognizedWords;
        print("User said: $userSpoke");
        
        // 1. Get AI Answer
        String aiReply = await SparkAiCore.generateResponse(userSpoke, isPro, persona == "Spark");
        
        // 2. Speak it out loud
        await AudioService().speak(aiReply);
        
        // 3. Loop back to listening after a 2-second pause
        Future.delayed(const Duration(seconds: 4), () {
          if (_isConversing) _listenAndRespond(persona, isPro);
        });
      }
    });
  }

  static void endConversation() {
    _isConversing = false;
    _stt.stop();
    AudioService().stop();
  }
}