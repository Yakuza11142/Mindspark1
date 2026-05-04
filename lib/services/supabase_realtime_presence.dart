import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRealtimePresence {
  static void trackPresence(String userId) {
    final channel = Supabase.instance.client.channel('online-users');
    channel.onPresenceSync((payload) {
      print('Synced presence state: $payload');
    }).subscribe((status,[error]) async {
      if (status == RealtimeSubscribeStatus.subscribed) {
        await channel.track({'user_id': userId, 'online_at': DateTime.now().toIso8601String()});
      }
    });
  }
}