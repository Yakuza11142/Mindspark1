import 'package:audioplayers/audioplayers.dart';

class AudioInterruptionHandler {
  static void listen(AudioPlayer player) {
    player.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.paused) {
        print("Audio interrupted (e.g., phone call). Pausing AI.");
      }
    });
  }
}