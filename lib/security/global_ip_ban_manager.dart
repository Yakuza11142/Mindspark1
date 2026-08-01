import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:developer' as developer;

class GlobalIpBanManager {
  // Extracted static tables and column keys to prevent string hardcoding errors
  static const String _tableBlacklist = 'global_ip_blacklist';
  static const String _columnIpAddress = 'ip_address';

  /// Connects to your Supabase instance asynchronously to check global IP blacklist restrictions
  static Future<bool> isIpBanned(String ipAddress) async {
    // Sanitize basic input string length parameters to reject clearly malformed network inputs early
    final String sanitizedIp = ipAddress.trim();
    if (sanitizedIp.isEmpty) return false;

    try {
      // Connect to the Supabase client instance safely via filters
      final List<Map<String, dynamic>> response = await Supabase.instance.client
          .from(_tableBlacklist)
          .select(_columnIpAddress)
          .eq(_columnIpAddress, sanitizedIp)
          .limit(1); // Stop scanning immediately after the first match to maximize database performance

      // If the array contains an element, the requested IP addresses matches your ban criteria
      return response.isNotEmpty;
    } catch (error, stackTrace) {
      // Graceful error logging to ensure API connection failures don't crash your entire client app execution
      developer.log(
        "❌ IP Ban Check Failure: Problem contacting backend security rules.", 
        error: error, 
        stackTrace: stackTrace,
      );
      
      // Fail-secure or fail-open selection depending on product architecture preferences:
      // Returning false ensures a temporary Supabase service interruption won't lock legitimate users out.
      return false; 
    }
  }
}
