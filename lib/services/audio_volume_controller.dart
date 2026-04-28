import 'package:audioplayers/audioplayers.dart';

class AudioVolumeController {
  static final AudioPlayer player = AudioPlayer();
  
  static void setVolume(double volumeLevel) {
    player.setVolume(volumeLevel); // 0.0 to 1.0
  }
}