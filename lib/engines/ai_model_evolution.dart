import 'package:supabase_flutter/supabase_flutter.dart';

class AiModelEvolution {
  /// Infinite storage for all providers. 
  /// Key: 'provider_name' (e.g., "groq"), Value: 'model_string' (e.g., "llama3-70b")
  static final Map<String, String> brains = {};

  /// Listens for ANY number of rows in the 'ai_versions' table.
  /// If you add 100 rows, it syncs all 100 instantly.
  static void startInfiniteSync() {
    final client = Supabase.instance.client;

    client
        .from('ai_versions')
        .stream(primaryKey: ['provider_name']) // Connects to the table live
        .listen((List<Map<String, dynamic>> rows) {
          for (var row in rows) {
            // This loop makes it infinite: it maps EVERY row to the 'brains' map
            final String name = row['provider_name'];
            final String version = row['model_string'];
            
            brains[name] = version;
          }
          print("🧠 All AI Brains Updated: $brains");
        });
  }

  /// Use this to get any model dynamically
  static String getModel(String provider) => brains[provider] ?? "default-model";
}
