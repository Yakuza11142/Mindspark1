class VolumetricAvatar {
  final String name;
  final String glbUrl; // Link to the 3D rigged character file
  final String idleAnimation; // e.g., 'Breathing'
  final String talkingAnimation; // e.g., 'Explaining'

  VolumetricAvatar(this.name, this.glbUrl, this.idleAnimation, this.talkingAnimation);
}