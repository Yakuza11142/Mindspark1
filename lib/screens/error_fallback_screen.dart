import 'package:flutter/material.dart';

class ErrorFallbackScreen extends StatelessWidget {
  const ErrorFallbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: Text("System recalibrating...", style: TextStyle(color: Colors.cyanAccent))),
    );
  }
}