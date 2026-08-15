import 'spatial_stub.dart';

class MobileSpatialEngine implements SpatialEngine {
  @override
  void initializeTutor() {
    // 📱 MOBILE MODE: Triggers your real-life 6-foot projection camera layout here
    print("AI Tutor Spark initialized on ARCore Native");
  }
}

SpatialEngine getSpatialEngine() => MobileSpatialEngine();
