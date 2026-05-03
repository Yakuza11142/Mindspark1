class NetworkLatencyOptimizer {
  static bool shouldUseLighterModel(int pingMs) {
    return pingMs > 500; // If network is very slow, force local models
  }
}