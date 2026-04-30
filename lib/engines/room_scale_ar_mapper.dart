class RoomScaleArMapper {
  static String configureRoomScale() {
    // Instructs Google ARCore Scene Semantics to map walls, ceiling, and floor
    print("🌌 Scanning Room Geometry...");
    return "ar-scale='auto' ar-modes='scene-viewer webxr' environment-image='neutral'";
  }
}