import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_env.dart';

class SupabaseInitializer {
  static Future<void> init() async {
    await Supabase.initialize(
      url: SupabaseEnv.projectUrl,
      anonKey: SupabaseEnv.anonKey,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce, // Industry standard secure auth flow
      ),
    );
    print("☁️ Supabase Cloud Database Connected Successfully.");
  }
}