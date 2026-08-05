import 'package:supabase_flutter/supabase_flutter.dart';

final _supabase = Supabase.instance.client;

// Global Privacy States
User? get currentUser => _supabase.auth.currentUser;
bool get isSignedIn => _supabase.auth.currentUser != null;

/// Global Auth Service with GDPR/COPPA safety checks
class GlobalAuth {
  /// GDPR: Explicitly log and verify consent before processing personal data.
  /// COPPA: If isMinor is true, you must block registration or trigger parent flow.
  static Future<bool> secureSignUp({
    required String email, 
    required String password,
    required bool hasConsented, // Mandatory GDPR Check
    required bool isMinor,      // Mandatory COPPA Check
  }) async {
    if (!hasConsented) return false;

    if (isMinor) {
      print("COPPA RESTRICTION: Parental consent flow required.");
      return false; 
    }

    try {
      await _supabase.auth.signUp(
        email: email, 
        password: password,
        data: { 'consent_version': 'v1.0', 'consent_date': DateTime.now().toIso8601String() },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> login(String email, String password) async {
    try {
      await _supabase.auth.signInWithPassword(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// GDPR Right to Erasure: Allow users to delete their account and data easily.
  static Future<void> deleteUserAccount() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      await _supabase.auth.admin.deleteUser(user.id);
    }
  }
}

class GlobalPrivacyAuth {
  static Future<bool> secureRegister({
    required String email,
    required String password,
    required int age,
  }) async {
    // COPPA Protocol: Users under 13 go to Edge Process
    if (age < 13) {
      return await _processChildAccountViaEdge(email, password, age);
    }

    try {
      await _supabase.auth.signUp(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> _processChildAccountViaEdge(String email, String password, int age) async {
    try {
      final response = await _supabase.functions.invoke(
        'handle-child-data',
        body: {'email': email, 'password': password, 'age': age},
      );
      return response.status == 200;
    } catch (e) {
      return false;
    }
  }
}
