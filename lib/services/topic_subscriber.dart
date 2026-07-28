class TopicSubscriber {
  static void subscribeToDaily() {
    SupabaseMessaging.instance.subscribeToTopic('daily_tips');
  }
}
