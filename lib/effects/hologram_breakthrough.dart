import 'package:flutter/material.dart';
import 'dart:math' as math;

class HologramBreakthrough extends StatefulWidget {
  @override
  _HologramBreakthroughState createState() => _HologramBreakthroughState();
}

class _HologramBreakthroughState extends State<HologramBreakthrough> {
  double x = 0;
  double y = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              y = y - details.delta.dx / 100;
              x = x + details.delta.dy / 100;
            });
          },
          child: Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // The "Bypass" - Creates 3D Depth
              ..rotateX(x)
              ..rotateY(y),
            child: Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                color: Colors.cyanAccent.withOpacity(0.5),
                boxShadow: [
                  BoxShadow(color: Colors.cyanAccent, blurRadius: 40, spreadRadius: 10)
                ],
              ),
              child: const Icon(Icons.favorite, color: Colors.white, size: 100),
            ),
          ),
        ),
      ),
    );
  }
}
