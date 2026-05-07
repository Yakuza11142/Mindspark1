import 'dart:ui';
import 'package:flutter/material.dart';
import '../screens/paywall_screen.dart';

class ProFeatureLock extends StatelessWidget {
  final Widget child;
  final bool isPro;
  const ProFeatureLock({super.key, required this.child, required this.isPro});

  @override
  Widget build(BuildContext context) {
    if (isPro) return child; // Let them through
    
    return Stack(
      children:[
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: IgnorePointer(child: child), // Cannot interact with it
        ),
        Positioned.fill(
          child: Center(
            child: ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaywallScreen())),
              icon: const Icon(Icons.lock, color: Colors.amber),
              label: const Text("UNLOCK PRO", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent),
            ),
          ),
        ),
      ],
    );
  }
}