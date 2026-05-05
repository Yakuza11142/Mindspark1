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
    // 1. GDPR Guard: Do not process if consent isn't clear.
    if (!hasConsented) return false;

    // 2. COPPA Guard: Block if under 13 (or trigger parent authorization).
    if (isMinor) {
      print("COPPA RESTRICTION: Parental consent flow required.");
      return false; 
    }

    try {
      await _supabase.auth.signUp(
        email: email, 
        password: password,
        // GDPR Best Practice: Store consent version in user metadata
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
    // Note: Deletion usually requires a database trigger or edge function 
    // to clean up all related PII (Personally Identifiable Information).
    await _supabase.auth.admin.deleteUser(_supabase.auth.currentUser!.id); 
  }
}
import 'package:supabase_flutter/supabase_flutter.dart';

final _supabase = Supabase.instance.client;

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

    // Standard GDPR-compliant flow for adults
    try {
      await _supabase.auth.signUp(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> _processChildAccountViaEdge(String email, String password, int age) async {
    try {
      // Calls a custom Edge Function named 'handle-child-data'
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
// supabase/functions/handle-child-data/index.ts
import { serve } from "https://deno.land"

serve(async (req) => {
  const { email, password, age } = await req.json()

  // 1. COPPA Safety: Tag the data as 'unverified_minor'
  // 2. Encrypt or store in a isolated 'pending_verification' table
  // 3. Trigger an email to the parent for Verifiable Parental Consent (VPC)
  
  console.log(`Processing sensitive minor data for: ${email}`)

  return new Response(
    JSON.stringify({ message: "Parental consent required to proceed." }),
    { headers: { "Content-Type": "application/json" }, status: 200 }
  )
})
