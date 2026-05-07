import 'package:supabase_messaging/supabase_messaging.dart';

class TopicSubscriber {
  static void subscribeToDaily() {
    SupabaseMessaging.instance.subscribeToTopic('daily_tips');
  }
}