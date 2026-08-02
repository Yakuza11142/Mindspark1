import 'package:supabase_flutter/supabase_flutter.dart';

class SubscriptionVerifier {
  static final _supabase = Supabase.instance.client;

  /// Verifies a Google Play receipt token securely via your backend edge script.
  /// Returns [true] if the server validates the subscription.
  static Future<bool> verifyAndUpgradeSubscription({
    required String purchaseToken,
    required String productId,
    required String packageName,
  }) async {
    try {
      // Calls the secure Deno edge pipeline wrapper instead of directly modifying tables
      final FunctionResponse response = await _supabase.functions.invoke(
        'verify-google-play',
        body: {
          'purchase_token': purchaseToken,
          'product_id': productId,
          'package_name': packageName,
        },
      );

      return response.status == 200;
    } catch (e) {
      print("Google Play server validation failure: $e");
      return false;
    }
  }
}
