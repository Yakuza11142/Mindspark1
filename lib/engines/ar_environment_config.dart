class ArEnvironmentConfig {
  static String getRealisticLighting() {
    // This injects HDR (High Dynamic Range) lighting into the 3D model.
    // It makes the digital object reflect the actual lights in the user's room.
    return "neutral"; 
  }

  static String getShadowIntensity() {
    // Makes the 3D object cast a real shadow on the physical floor
    return "1.5"; 
  }

  static String getArModes() {
    // Tells the phone to try Android ARCore first, WebXR second, and iOS ARKit (Quick Look) third.
    return "scene-viewer webxr quick-look";
  }
}