void handleAnatomyTap(String name, ArCoreController controller, v.Vector3 handPos) {
  // If user taps the brain, the AH 'gestures' and spawns the file
  if (name == "internal_brain") {
    print(AHBrainLogic.think(name));
    
    // Instant spawn from the hand
    final whaleId = "whale_lesson_${DateTime.now().millisecond}";
    EduFactory.spawnHandSizedWhale(controller, handPos); 
  }
}
