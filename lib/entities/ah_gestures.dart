void performThrowGesture(ArCoreController controller, v.Vector3 targetPos) {
  // 1. Calculate IK angles for the hand to reach 'targetPos'
  // (Uses the solve(upper, lower, target) math from previous step)
  
  // 2. Move AH Hand Node to targetPos
  
  // 3. Instant Spawn (The AH "creates" the file from its hand)
  final fileId = "edu_file_${HologramMemory.getAllSavedIds().length}";
  EduFactory.spawnLessonOrb(controller, targetPos, fileId);
  
  // 4. Remember it
  HologramMemory.saveFile(fileId, targetPos, "Quantum Physics Lesson 1");
}
