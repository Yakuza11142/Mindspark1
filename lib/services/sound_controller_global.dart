class SoundControllerGlobal {
  static bool isMuted = false;
  static void toggle() => isMuted = !isMuted;
}