class ProGatekeeper {
  static bool verify(bool isPro) {
    if (!isPro) {
      print("🛑 BLOCK: Free user attempted to access Paid API.");
      return false;
    }
    return true;
  }
}