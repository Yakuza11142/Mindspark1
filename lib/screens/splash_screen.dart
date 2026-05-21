import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../lidar_engine.dart'; // REQUIRED: Imports your LiDAR code file

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      // CHANGED: Redirects the user directly into your LiDAR camera scanner view
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (_) => const LidarMimicEngine())
      );
    });
    
    return Scaffold(
      body: Center(
        child: const Icon(Icons.bolt, size: 80, color: Colors.amber)
            .animate().scale(duration: 600.ms).then().shake(),
      ),
    );
  }
}
