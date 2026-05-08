import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfigHelper {
  final _client = Supabase.instance.client;
  Map<String, dynamic> _cache = {};

  // Initialize and "fetch" all keys at once
  Future<void> init() async {
    final List<Map<String, dynamic>> data = await _client
        .from('app_config')
        .select('key, value');

    // Convert the table list into a searchable "Master Key" Map
    _cache = {for (var item in data) item['key']: item['value']};
  }

  // Master Getter: No hardcoding. Use the exact key from your DB.
  T get<T>(String key, T defaultValue) {
    if (!_cache.containsKey(key)) return defaultValue;
    return _cache[key] as T;
  }

  // Real-time Update: If the government changes a "cable", your app knows
  Stream<List<Map<String, dynamic>>> listenToConfigChanges() {
    return _client.from('app_config').stream(primaryKey: ['key']);
  }
}
