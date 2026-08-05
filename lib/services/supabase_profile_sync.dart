import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Assumption based on your project configuration bindings:
abstract class SupabaseCoreConfig {
  static final SupabaseClient client = Supabase.instance.client;
}

class SupabaseProfileSync {
  /// Calls the Edge Function to sync profile data in the cloud
  static Future<void> syncProfile(String name, String avatarUrl) async {
    final user = SupabaseCoreConfig.client.auth.currentUser;
    if (user == null) {
      debugPrint("Sync Error: No authenticated user.");
      return;
    }

    try {
      final response = await SupabaseCoreConfig.client.functions.invoke(
        'sync-profile',
        body: {
          'user_id': user.id,
          'name': name,
          'avatar_url': avatarUrl,
        },
      );

      if (response.status == 200) {
        debugPrint("Profile successfully synced to cloud.");
      } else {
        debugPrint("Edge Sync Error: ${response.data}");
      }
    } catch (e) {
      debugPrint("Failed to contact Edge Function: $e");
    }
  }
}
