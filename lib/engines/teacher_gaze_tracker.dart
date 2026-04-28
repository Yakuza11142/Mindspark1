class TeacherGazeTracker {
  static String injectGazeTracking() {
    return "camera-target='auto' auto-rotate='false'"; // Locks focus to user perspective
  }
}