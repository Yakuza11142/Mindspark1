class CognitiveLoadBalancer {
  static String suggestLearningMode(int minutesStudied) {
    if (minutesStudied > 120) {
      return "VISUAL_ONLY"; // Turn off text, show 3D/Video to rest the reading brain
    }
    return "TEXT_AND_VISUAL";
  }
}