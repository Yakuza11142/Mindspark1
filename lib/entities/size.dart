// 🚀 CI AUTO-REMOVED: // 🚀 CI AUTO-REMOVED: void spawnHandSizedWhale(ArCoreController controller, v.Vector3 handPos) {
// 🚀 CI AUTO-REMOVED:   final whaleNode = ArCoreNode(
    // Loads the 3D whale model (must be in your assets)
    shape: ArCoreReferenceNode(objectUrl: "assets/blue_whale.glb"),
    position: handPos,
    // Scale: 0.005 shrinks a 30m whale to 15cm (hand-size)
// 🚀 CI AUTO-REMOVED:     scale: v.Vector3(0.005, 0.005, 0.005),
    name: "student_whale_${DateTime.now().millisecond}",
  );

  controller.addArCoreNode(whaleNode);
}
