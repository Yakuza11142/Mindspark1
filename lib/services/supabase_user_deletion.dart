import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:developer' as developer;

class SupabaseUserDeletion {
  // Centralized endpoint key registry to prevent hardcoded string repetition
  static const String _edgeFunctionName = 'delete_user_account';

  /// Asynchronously triggers the administrative edge function to safely remove user data profiles.
  static Future<bool> deleteMyAccount() async {
    try {
      final SupabaseClient client = Supabase.instance.client;

      // 1. Fire the execution request to your secure backend edge function channel
      final FunctionResponse response = await client.functions.invoke(
        _edgeFunctionName,
        method: HttpMethod.post, // Explicitly enforce POST methods for write actions
      );

      // 2. Structural status check: Validate if the cloud server completed the transaction smoothly
      if (response.status != 200) {
        developer.log("⚠️ Deletion Shield: Server returned an invalid response code: ${response.status}");
        return false;
      }

      developer.log("🎯 Deletion Shield: Remote user account wipe confirmed. Processing local sign-out cleanup...");

      // 3. FIX: Only clear local session parameters once the database removal loop completes
      await client.auth.signOut();
      return true;
    } on FunctionException catch (functionError, stackTrace) {
      developer.log(
        "🚨 Deletion Shield Failure: Edge function rejected account deletion protocols.",
        error: functionError,
        stackTrace: stackTrace,
      );
      return false; // Fail-secure: Keep the active local session intact to allow retry alerts
    } catch (genericError, stackTrace) {
      developer.log(
        "🚨 Deletion Shield Failure: Unexpected pipeline error while processing authentication data cleanup.",
        error: genericError,
        stackTrace: stackTrace,
      );
      return false;
    }
  }
}
