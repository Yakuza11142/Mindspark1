import 'package:audioplayers/audioplayers.dart';

class SoundManager {
  final AudioPlayer _player = AudioPlayer();

  // Add small MP3s to assets/sounds/
  void playClick() async => await _player.play(AssetSource('sounds/click.mp3'), volume: 0.5);
  void playSuccess() async => await _player.play(AssetSource('sounds/success.mp3'));
  void playError() async => await _player.play(AssetSource('sounds/error.mp3'));
}