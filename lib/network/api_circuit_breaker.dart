class ApiCircuitBreaker {
  static int _failedCalls = 0;
  static bool _circuitOpen = false; // If true, stop hitting the API

  static bool canCallApi() {
    if (_circuitOpen) return false;
    return true;
  }

  static void recordFailure() {
    _failedCalls++;
    if (_failedCalls >= 3) {
      _circuitOpen = true;
      print("🔌 API CIRCUIT TRIPPED. Falling back to local Megalith Engine.");
      // Automatically close circuit after 60 seconds
      Future.delayed(const Duration(seconds: 60), () {
        _circuitOpen = false;
        _failedCalls = 0;
      });
    }
  }

  static void recordSuccess() {
    _failedCalls = 0;
    _circuitOpen = false;
  }
}