class AvatarAnimationSync {
  static String currentAnimation = "Idle";

  static String syncWithAudio(bool isAudioPlaying, String idleAnim, String talkAnim) {
    return isAudioPlaying ? talkAnim : idleAnim;
  }
}