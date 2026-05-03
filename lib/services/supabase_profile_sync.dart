import '../config/supabase_core_config.dart';

class SupabaseProfileSync {
  /// Calls the Edge Function to sync profile data in the cloud
  static Future<void> syncProfile(String name, String avatarUrl) async {
    final user = SupabaseCoreConfig.client.auth.currentUser;
    if (user == null) {
      print("Sync Error: No authenticated user.");
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
        print("Profile successfully synced to cloud.");
      } else {
        print("Edge Sync Error: ${response.data}");
      }
    } catch (e) {
      print("Failed to contact Edge Function: $e");
    }
  }
}
// supabase/functions/sync-profile/index.ts
import { createClient } from 'jsr:@supabase/supabase-js@2'

Deno.serve(async (req) => {
  try {
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    // Get the request body
    const { name, avatar_url, user_id } = await req.json()

    if (!user_id) throw new Error('User ID is required')

    const { data, error } = await supabase
      .from('profiles')
      .upsert({
        id: user_id,
        name,
        avatar_url,
        updated_at: new Date().toISOString(),
      })
      .select()

    if (error) throw error

    return new Response(JSON.stringify(data), { 
      headers: { "Content-Type": "application/json" } 
    })
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 400 })
  }
})
