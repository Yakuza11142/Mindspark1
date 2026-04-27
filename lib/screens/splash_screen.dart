import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'main_layout_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainLayoutScreen()));
    });
    return Scaffold(
      body: Center(
        child: const Icon(Icons.bolt, size: 80, color: Colors.amber)
            .animate().scale(duration: 600.ms).then().shake(),
      ),
    );
  }
}