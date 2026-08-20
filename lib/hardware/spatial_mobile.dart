import 'spatial_stub.dart';

class MobileSpatialEngine implements SpatialEngine {
  @override
  void initializeTutor() {
    print("AI Tutor Spark initialized");
  }
}

SpatialEngine getSpatialEngine() => MobileSpatialEngine();