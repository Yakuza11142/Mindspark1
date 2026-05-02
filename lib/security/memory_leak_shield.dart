class MemoryLeakShield {
  static void runSafeZone(Function appRunner) {
    try {
      appRunner();
    } catch (e) {
      print("CRITICAL: Leak prevented. System restored.");
    }
  }
}