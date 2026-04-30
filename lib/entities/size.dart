void spawnHandSizedWhale(ArCoreController controller, v.Vector3 handPos) {
  final whaleNode = ArCoreNode(
    // Loads the 3D whale model (must be in your assets)
    shape: ArCoreReferenceNode(objectUrl: "assets/blue_whale.glb"),
    position: handPos,
    // Scale: 0.005 shrinks a 30m whale to 15cm (hand-size)
    scale: v.Vector3(0.005, 0.005, 0.005),
    name: "student_whale_${DateTime.now().millisecond}",
  );

  controller.addArCoreNode(whaleNode);
}
