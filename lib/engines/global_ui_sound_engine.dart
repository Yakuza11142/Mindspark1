import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class GlobalUiSoundEngine {
  // We use a pool of players so sounds can overlap without cutting each other off
  static final AudioPlayer _tapPlayer = AudioPlayer();
  static final AudioPlayer _successPlayer = AudioPlayer();
  static final AudioPlayer _errorPlayer = AudioPlayer();
  static final AudioPlayer _swipePlayer = AudioPlayer();
  static final AudioPlayer _cashPlayer = AudioPlayer();

  static Future<void> preWarmSounds() async {
    // Loads sounds into RAM the millisecond the app opens
    await _tapPlayer.setSource(AssetSource('sounds/ui_tap.mp3'));
    await _successPlayer.setSource(AssetSource('sounds/ui_success.mp3'));
    await _errorPlayer.setSource(AssetSource('sounds/ui_error.mp3'));
    await _swipePlayer.setSource(AssetSource('sounds/ui_swipe.mp3'));
    await _cashPlayer.setSource(AssetSource('sounds/sparks_earned.mp3'));
    print("🔊 Global Acoustic Interface: ONLINE.");
  }

  static void playTap() {
    _tapPlayer.resume();
    HapticFeedback.lightImpact(); // Sound + Touch fusion
  }

  static void playSuccess() {
    _successPlayer.resume();
    HapticFeedback.mediumImpact();
  }

  static void playError() {
    _errorPlayer.resume();
    HapticFeedback.heavyImpact();
  }

  static void playSwipe() {
    _swipePlayer.resume();
  }

  static void playSparksEarned() {
    _cashPlayer.resume();
    HapticFeedback.vibrate();
  }
}