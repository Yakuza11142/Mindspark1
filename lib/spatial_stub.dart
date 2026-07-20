// lib/spatial_stub.dart
abstract class SpatialEngine {
  void initializeTutor();
}

SpatialEngine getSpatialEngine() => throw UnsupportedError('Cannot create engine');
