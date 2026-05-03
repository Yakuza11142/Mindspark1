import 'package:supabase_flutter/supabase_flutter.dart';

class ApiLatencyLogger {
  static void log(String endpoint, int ms) {
    Supabase.instance.client.rpc('log_latency', params: {'p_endpoint': endpoint, 'p_ms': ms});
  }
}