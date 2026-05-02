class MultiTimezoneSync {
  static bool isLocalMidnight() {
    return DateTime.now().hour == 0; // Uses device's local clock perfectly
  }
}