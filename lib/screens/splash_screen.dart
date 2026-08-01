import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../lidar_engine.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToScanner();
  }

  void _navigateToScanner() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LidarMimicEngine()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Core Icon
            const Icon(Icons.bolt, size: 80, color: Colors.amber)
                .animate()
                .scale(duration: 600.ms)
                .then()
                .shake(),
            
            const SizedBox(height: 40),

            // Linear Progress Indicator Track
            SizedBox(
              width: 160,
              child: const LinearProgressIndicator(
                backgroundColor: Colors.white10,
                color: Colors.amber,
                minHeight: 4,
              )
              .animate()
              .fadeIn(delay: 400.ms, duration: 400.ms),
            ),
          ],
        ),
      ),
    );
  }
}
