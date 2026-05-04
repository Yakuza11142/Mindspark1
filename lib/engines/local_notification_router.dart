import 'package:flutter/material.dart';

class LocalNotificationRouter {
  static void handleRouting(BuildContext context, Map<String, dynamic> data) {
    if (data['route'] == 'weekly_quiz') {
      Navigator.pushNamed(context, '/quiz');
    } else if (data['route'] == 'discount_offer') {
      Navigator.pushNamed(context, '/paywall');
    }
  }
}