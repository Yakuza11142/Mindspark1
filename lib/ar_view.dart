// Inside your ArCoreView setup
controller.onNodeTap = (name) {
  if (name == "AH_HEAD") {
    // AH Spawns a new lesson instantly
    v.Vector3 spawnPos = v.Vector3(0.4, 0.5, -1.2);
    EduFactory.spawnLessonOrb(arCoreController!, spawnPos, "lesson_time_dilation");
  } else if (name.startsWith("lesson_")) {
    // User interacted with the educational secondary hologram
    _showLessonDetail(name); 
    // Option: Make it disappear at will after reading
    arCoreController?.removeNode(nodeName: name);
  }
};

void _showLessonDetail(String id) {
  // Logic to show "Time Dilation: Objects moving at high speed experience time slower."
  // This bridges the AR world with your Confidence Matrix data.
}
