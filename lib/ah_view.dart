void _onFaceScanned(List<Face> faces) {
  for (Face face in faces) {
    // If scanning the CEO
    if (isCEO(face)) {
// 🚀 CI AUTO-REMOVED:       ah.performCEOGreeting(); // Special IK Gesture
// 🚀 CI AUTO-REMOVED:       ah.unlockMasterControls();
    } else {
      // Standard student interaction
// 🚀 CI AUTO-REMOVED:       ah.assignStudentId(face.trackingId);
// 🚀 CI AUTO-REMOVED:       ah.projectHandWhale(face.boundingBox.center);
    }
  }
}
