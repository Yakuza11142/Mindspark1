import 'package:flutter/material.dart';

class CinematicLoadingScreen extends StatelessWidget {
  const CinematicLoadingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: Text("Fusing Runway AI & HeyGen...", style: TextStyle(color: Colors.cyanAccent, letterSpacing: 2))),
    );
  }
}