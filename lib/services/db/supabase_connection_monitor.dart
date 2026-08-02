import 'dart:io';
import 'package:http/http.dart' as http; // Standard lightweight HTTP package
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConnectionMonitor {
  static final _supabase = Supabase.instance.client;

  /// Performs an ultra-lightweight ping to the Supabase REST edge health endpoint.
  /// Bypasses PostgREST and database engine processing to protect monthly API quotas.
  static Future<bool> isCloudReachable() async {
    try {
      // 1. Extract your project base URL dynamically from the active client
      final String supabaseUrl = _supabase.supabaseUrl;
      
      // 2. Target the native unauthenticated health endpoint
      final Uri healthUri = Uri.parse('$supabaseUrl/rest/v1/');

      // 3. Perform a fast GET request with a short timeout threshold
      final response = await http.get(healthUri, headers: {
        'apikey': _supabase.supabaseKey, // Required by edge routing gateways
      }).timeout(const Duration(seconds: 4));

      // The REST API gateway returns an empty response or basic documentation JSON on success
      return response.statusCode == 200;
    } on SocketException catch (_) {
      // Device has no local routing pathway or cellular link
      return false;
    } on HttpException catch (_) {
      // Remote web server unreachable or returned malformed data
      return false;
    } catch (e) {
      // Catches timeouts or missing parameters cleanly
      print("Supabase connection check timeout/failure: $e");
      return false;
    }
  }
}
