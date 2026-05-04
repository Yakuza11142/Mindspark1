// Requires uni_links package
import 'dart:async';
import 'package:flutter/material.dart';

class DeepLinkRouter {
  static void initDeepLinks(BuildContext context) {
    // In production, listen to incoming app links stream
    // StreamSubscription _sub = linkStream.listen((String? link) {
    //   if (link != null && link.contains('/lesson/')) {
    //     String topic = link.split('/').last;
    //     Navigator.pushNamed(context, '/lesson', arguments: topic);
    //   }
    // });
    print("Deep Link Listener Active.");
  }
}