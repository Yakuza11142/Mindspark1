import '../services/elevenlabs_ah_voice.dart';
import 'ah_voice_link_engine.dart';

class AutoInterruptionHandler {
  static void interruptAndListen() {
    ElevenLabsAhVoice.stopAudio(); // Cut the AI off
    print("🛑 AI Interrupted by User.");
    // AhVoiceLinkEngine.startListening(...)
  }
}