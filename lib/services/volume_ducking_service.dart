import 'package:audioplayers/audioplayers.dart';

class VolumeDuckingService {
  static void duckBackgroundMusic(AudioPlayer bgPlayer, bool isAiSpeaking) {
    if (isAiSpeaking) {
      // Lower ambient noise to 10%
      bgPlayer.setVolume(0.1);
      print("🔉 Ducking ambient audio. AI is speaking.");
    } else {
      // Return ambient noise to normal
      bgPlayer.setVolume(0.4);
      print("🔊 Restoring ambient audio.");
    }
  }
}