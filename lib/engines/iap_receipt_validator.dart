import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer' as developer;

class InAppPurchaseVerifier {
  /// Validates an IAP purchase via Supabase Edge Functions securely using explicit network constraints
  static Future<bool> verifyPurchaseWithSupabase(String purchaseToken, String productId) async {
    developer.log("🛒 IAP Verifier: Initiating secure verification loop for product asset ID: $productId");

    try {
      // Standardized environment access patterns to guarantee consistent string-parsing lookups across all platform lints
      final String baseUrl = dotenv.get('SUPABASE_URL', fallback: '').trim();
      final String anonKey = dotenv.get('SUPABASE_ANON_KEY', fallback: '').trim();

      if (baseUrl.isEmpty || anonKey.isEmpty) {
        throw StateError("Supabase initialization parameters are missing or unpopulated within active .env profiles.");
      }

      final Uri url = Uri.parse("$baseUrl/functions/v1/verify-receipt");

      final Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $anonKey"
      };

      final http.Response res = await http.post(
        url,
        headers: headers,
        body: jsonEncode({
          "token": purchaseToken.trim(), 
          "productId": productId.trim(),
        }),
      ).timeout(
        const Duration(seconds: 10),
      );

      if (res.statusCode == 200) {
        final dynamic decodedPayload = jsonDecode(res.body);
        
        if (decodedPayload is Map) {
          final Map<String, dynamic> structuredJson = Map<String, dynamic>.from(decodedPayload);
          return structuredJson['is_valid'] == true;
        }
        
        throw FormatException("Server returned an invalid JSON object format structure. Expected a structural Map container.");
      } else {
        developer.log("⚠️ IAP Verifier: Upstream validation function rejected token with status code: ${res.statusCode}");
        return false; 
      }
    } catch (e, stackTrace) {
      developer.log("❌ IAP Verifier: Transaction verification pipeline encountered an unexpected exception", error: e, stackTrace: stackTrace);
      return false; 
    }
  }

  /// Entry orchestration framework executing structural payment tracking flows safely
  static Future<void> handlePurchase(BuildContext context, String token, String product) async {
    final bool isValid = await verifyPurchaseWithSupabase(token, product);

    // Enforce a strict atomic context check boundary prior to evaluating state data adjustments
    if (!context.mounted) {
      developer.log("⚠️ IAP Verifier: Context unmounted during background network lookup. Aborting state synchronization.");
      return;
    }

    if (isValid) {
      developer.log("👑 IAP Verifier: Purchase valid. Unlocking premium application tiers.");
      // Securely execute content activation mutations safely knowing the view layer is actively mounted on screen
    } else {
      developer.log("⚠️ IAP Verifier: Receipt verification failed. Showing transaction feedback UI.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transaction verification failed. Please contact support if this persists.')),
      );
    }
  }
}
