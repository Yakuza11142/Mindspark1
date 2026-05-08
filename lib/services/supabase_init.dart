import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseInit {
  static Future<void> setup() async {
    await Supabase.initialize(
      url: 'https://supabase.co', // The 'Cable' to your cloud
      anonKey: 'your-anon-public-key', // The 'Privilege Key' for access
    );
    
    print("⚡ Mind Spark Foundation Connected to Supabase");
  }
}
