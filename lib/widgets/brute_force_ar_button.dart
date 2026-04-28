import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../engines/native_ar_launcher.dart';

class BruteForceArButton extends StatelessWidget {
  final String glbUrl;
  final String topicName;
  
  const BruteForceArButton({super.key, required this.glbUrl, required this.topicName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Trigger the native Android AR override
        NativeArLauncher.launchHologram(glbUrl, topicName);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors:[Colors.purpleAccent, Colors.cyanAccent]),
          borderRadius: BorderRadius.circular(30),
          boxShadow:[BoxShadow(color: Colors.cyanAccent.withOpacity(0.5), blurRadius: 15, spreadRadius: 2)]
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children:[
            Icon(Icons.view_in_ar, color: Colors.black, size: 24),
            SizedBox(width: 10),
            Text("PROJECT HOLOGRAM", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1)),
          ],
        ),
      ).animate(onPlay: (c) => c.repeat(reverse: true)).scaleXY(end: 1.05),
    );
  }
}