import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseErrorHandler {
  /// Parses structured backend exceptions to return safe, user-friendly UI strings
  static String parseError(dynamic error) {
    // 1. Instantly handles explicit Supabase Database Postgrest Errors
    if (error is PostgrestException) {
      final String message = error.message.toLowerCase();
      if (message.contains('unique') || error.code == '23505') {
        return "This email is already registered.";
      }
      return error.message; // Returns the exact clean database hint if available
    }

    // 2. Handles explicit Supabase Auth Layer Exceptions
    if (error is AuthException) {
      return error.message;
    }

    // 3. Fallback to string scanning if dealing with raw socket/network payloads
    final String errorMessage = error.toString().toLowerCase();
    
    if (errorMessage.contains('socket') || errorMessage.contains('network')) {
      return "Network error. Queuing data for offline sync.";
    }

    return "A cloud error occurred. Please try again.";
  }
}
