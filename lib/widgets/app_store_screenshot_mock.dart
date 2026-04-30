import 'package:flutter/material.dart';

class AppStoreScreenshotMock extends StatelessWidget {
  const AppStoreScreenshotMock({super.key});
  @override
  Widget build(BuildContext context) {
    // Renders the app with fake "perfect" data for marketing screenshots
    return const Scaffold(backgroundColor: Colors.black, body: Center(child: Text("MARKETING UI RENDERED")));
  }
}