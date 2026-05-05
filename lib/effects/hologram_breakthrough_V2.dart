import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

class HologramBreakthrough extends StatefulWidget {
  const HologramBreakthrough({super.key});

  @override
  State<HologramBreakthrough> createState() => _HologramBreakthroughState();
}

class _HologramBreakthroughState extends State<HologramBreakthrough> {
  double x = 0; 
  double y = 0; 
  StreamSubscription? _gyroSubscription;

  @override
  void initState() {
    super.initState();
    // Gyroscope makes it "float" automatically
    _gyroSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        y += event.y * 0.02; 
        x += event.x * 0.02;
      });
    });
  }

  @override
  void dispose() {
    _gyroSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          // TOUCH LOGIC: Swipe to manually spin the hologram
          onPanUpdate: (details) {
            setState(() {
              y = y + details.delta.dx / 100;
              x = x - details.delta.dy / 100;
            });
          },
          child: Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002) // Visual Depth
              ..rotateX(x)
              ..rotateY(y),
            child: Container(
              height: 280,
              width: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.cyanAccent.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.6),
                    blurRadius: 60,
                    spreadRadius: 15,
                  ),
                ],
              ),
              child: const Icon(
                Icons.auto_awesome, // Sparkle icon fits "MindSpark" theme
                color: Colors.white,
                size: 180,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
