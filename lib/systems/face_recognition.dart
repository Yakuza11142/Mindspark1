void onFaceDetected(String faceId, ArCoreController controller, v.Vector3 ahPosition) {
  if (faceId == "CEO_MIND_SPARK_UNIQUE_ID") {
    // AH recognizes the CEO
    _triggerCEOGreeting(controller, ahPosition);
  } else {
    // AH recognizes a standard student
    _triggerStudentGreeting(controller, ahPosition);
  }
}

void _triggerCEOGreeting(ArCoreController controller, v.Vector3 pos) {
  // AH uses IK to salute the CEO
  print("Welcome, CEO of Mind Spark. Systems active.");
  // AH instantly spawns the 'Master Control' interface
  EduFactory.spawnMasterConsole(controller, pos + v.Vector3(0, 0.5, 0));
}
