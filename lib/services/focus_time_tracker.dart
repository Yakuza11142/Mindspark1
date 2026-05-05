class FocusTimeTracker {
  static DateTime? _start;
  static void startSession() => _start = DateTime.now();
  static int endSession() {
    if (_start == null) return 0;
    return DateTime.now().difference(_start!).inMinutes;
  }
}