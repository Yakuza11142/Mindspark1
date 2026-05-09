import '../engines/brain_engine.dart';
import '../services/audio_service.dart';

class VoiceChatEngine {
  static Future<void> chat(String userVoiceInput) async {
    // 1. Get Text Response
    String aiResponse = await BrainEngine().generateLesson(userVoiceInput, true, false);
    
    // 2. Speak it
    await AudioService().speak(aiResponse);
  }
}