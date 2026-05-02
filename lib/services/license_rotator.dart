import 'package:supabase_flutter/supabase_flutter.dart';

class BulkLicenseRotator {
  static Future<void> rotateLicenseCodes() async {
    // 1. Get the current year dynamically
    final int currentYear = DateTime.now().year;
    
    print("🔄 Initializing License Rotation for $currentYear...");

    try {
      // 2. Call your Supabase RPC function
      // Ensure your Supabase function is named 'generate_yearly_codes' 
      // and accepts an argument 'target_year'
      await Supabase.instance.client.rpc(
        'generate_yearly_codes', 
        params: {'target_year': currentYear},
      );

      print("✅ Success: New codes generated for $currentYear.");
    } catch (e) {
      print("❌ Error rotating codes: $e");
    }
  }
}
