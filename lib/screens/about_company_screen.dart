import 'package:flutter/material.dart';

class AboutCompanyScreen extends StatelessWidget {
  const AboutCompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About MindSpark")),
      body: const Center(child: Text("Mind Spark v1.0\nBuilding the future of education.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 16))),
    );
  }
}