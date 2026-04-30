void _onFaceScanned(List<Face> faces) {
  for (Face face in faces) {
    // If scanning the CEO
    if (isCEO(face)) {
      ah.performCEOGreeting(); // Special IK Gesture
      ah.unlockMasterControls();
    } else {
      // Standard student interaction
      ah.assignStudentId(face.trackingId);
      ah.projectHandWhale(face.boundingBox.center);
    }
  }
}
