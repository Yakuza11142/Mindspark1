// lib/spatial_web.dart
import 'spatial_stub.dart';

class WebSpatialEngine implements SpatialEngine {
  @override
  void initializeTutor() {
    // 🌐 WEB MODE: Initialize your vector calculations on a standard WebGL Canvas here
    print("AI Tutor Spark initialized on Web Canvas safely");
  }
}

SpatialEngine getSpatialEngine() => WebSpatialEngine();
