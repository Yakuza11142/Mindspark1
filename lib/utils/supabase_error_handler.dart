class SupabaseErrorHandler {
  static String parseError(dynamic error) {
    String e = error.toString().toLowerCase();
    if (e.contains('unique constraint')) return "This email is already registered.";
    if (e.contains('socket')) return "Network error. Queuing data for offline sync.";
    return "A cloud error occurred. Please try again.";
  }
}