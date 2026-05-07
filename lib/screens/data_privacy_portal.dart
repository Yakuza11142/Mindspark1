import 'package:flutter/material.dart';

class DataPrivacyPortal extends StatelessWidget {
  const DataPrivacyPortal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Data Privacy")),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "1. Exam History: Stored Locally.\n2. Audio Prompts: Sent securely to AI APIs. Not stored.\n3. Analytics: Anonymized for App Improvement.",
          style: TextStyle(color: Colors.white, fontSize: 16, height: 2),
        ),
      ),
    );
  }
}