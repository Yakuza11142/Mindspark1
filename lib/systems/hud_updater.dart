void updateHologramPositions(List<Face> detectedFaces, ArCoreController controller) {
  for (var face in detectedFaces) {
    final v.Vector3 newPos = _convertToARCoords(face.boundingBox.center);
    
    // Update the existing hologram instead of creating a new one
    controller.updateNodePosition(
      nodeName: "label_${face.trackingId}",
      newPosition: newPos + v.Vector3(0, 0.3, 0),
    );
  }
}
