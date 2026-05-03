import 'dart:convert';
import 'package:http/http.dart' as http;

/// Validates an IAP purchase with Supabase Edge Functions.
Future<bool> verifyPurchaseWithSupabase(String purchaseToken, String productId) async {
  // 1. Replace with your actual Edge Function URL
  final url = Uri.parse("https://YOUR_SUPABASE_URL.functions.supabase.co/verify-receipt");
  
  // 2. Replace with your actual ANON_KEY
  final headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer YOUR_ANON_KEY"
  };

  try {
    final res = await http.post(
      url,
      headers: headers,
      body: jsonEncode({"token": purchaseToken, "productId": productId}),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data['is_valid'] == true;
    } else {
      return false; // Function failed or returned error code
    }
  } catch (e) {
    print('Error validating purchase: $e');
    return false; // Reject on error for safety
  }
}
void handlePurchase(String token, String product) async {
  bool isValid = await verifyPurchaseWithSupabase(token, product);
  
  if (isValid) {
    // Unlock content
  } else {
    // Show error
  }
}
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env"); // Load the file
  runApp(const MyApp());
}
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<bool> verifyPurchaseWithSupabase(String purchaseToken, String productId) async {
  // Read keys from .env
  final baseUrl = dotenv.env['SUPABASE_URL'];
  final anonKey = dotenv.env['SUPABASE_ANON_KEY'];

  final url = Uri.parse("$baseUrl/functions/v1/verify-receipt");
  
  final headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $anonKey"
  };

  // ... (rest of the post request code)
}
