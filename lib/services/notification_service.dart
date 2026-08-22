import 'package:flutter/foundation.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  Future<void> init() async {
    debugPrint('[NotificationService] Initialized');
  }

  Future<void> showNotification(int id, String title, String body) async {
    debugPrint('[NotificationService] Notification Triggered:');
    debugPrint('  -> ID: $id');
    debugPrint('  -> Title: $title');
    debugPrint('  -> Body: $body');
  }

  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    debugPrint('[NotificationService] Scheduled Daily Notification:');
    debugPrint('  -> ID: $id | Time: $hour:$minute | Title: $title');
  }

  Future<void> scheduleDailyReminder() async {
    await scheduleDailyNotification(
      id: 101,
      title: 'Time to Learn!',
      body: 'Keep your streak going with a quick session on MindSpark.',
      hour: 20,
      minute: 0,
    );
  }

  Future<void> cancelNotification(int id) async {
    debugPrint('[NotificationService] Cancelled Notification ID: $id');
  }

  Future<void> cancelAll() async {
    debugPrint('[NotificationService] Cancelled All Notifications');
  }
}
