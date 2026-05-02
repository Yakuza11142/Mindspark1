import 'package:flutter/material.dart';
import '../widgets/zen_mode_background.dart';

class CalmDashboardScreen extends StatelessWidget {
  const CalmDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ZenModeBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: const Text("MindSpark Elite", style: TextStyle(color: Colors.cyanAccent)), backgroundColor: Colors.transparent, elevation: 0),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              const Icon(Icons.auto_awesome, size: 80, color: Colors.cyan),
              const SizedBox(height: 20),
              const Text("Welcome back. Breathe.", style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
              const Text("You are ready. Learn at your own pace.", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 40),
              ElevatedButton(onPressed: (){}, child: const Text("Continue Learning"))
            ],
          ),
        ),
      ),
    );
  }
}