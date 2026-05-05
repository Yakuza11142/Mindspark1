import 'package:flutter/material.dart';
import 'dart:math' as math;

class AdaptiveHologram extends StatefulWidget {
  final String userQuery; // e.g., "Show me a Human Heart"
  const AdaptiveHologram({super.key, required this.userQuery});

  @override
  State<AdaptiveHologram> createState() => _AdaptiveHologramState();
}

class _AdaptiveHologramState extends State<AdaptiveHologram> {
  double x = 0;
  double y = 0;
  double hologramHeight = 0; // Adjustable height

  @override
  Widget build(BuildContext context) {
    // Logic: If user mentions "hologram", we force specific breakthrough depth
    double depth = widget.userQuery.toLowerCase().contains("hologram") ? 0.006 : 0.002;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, depth) // The 0.006 "Bypass" depth
                ..translate(0.0, hologramHeight, 0.0) // Adjust Height
                ..rotateX(x)
                ..rotateY(y),
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    y += details.delta.dx / 100;
                    x -= details.delta.dy / 100;
                  });
                },
                child: HeroIconWidget(query: widget.userQuery),
              ),
            ),
          ),
          // Height Controller Slider
          Positioned(
            bottom: 50,
            left: 50,
            right: 50,
            child: Slider(
              value: hologramHeight,
              min: -300,
              max: 300,
              onChanged: (val) => setState(() => hologramHeight = val),
            ),
          ),
        ],
      ),
    );
  }
}

class HeroIconWidget extends StatelessWidget {
  final String query;
  const HeroIconWidget({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    // Simple logic to change icon based on what user asks for
    IconData icon = Icons.auto_awesome;
    if (query.contains("heart")) icon = Icons.favorite;
    if (query.contains("brain")) icon = Icons.psychology;
    if (query.contains("star")) icon = Icons.star;

    return Container(
      height: 250, width: 250,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.cyanAccent, blurRadius: 60, spreadRadius: 10)],
      ),
      child: Icon(icon, color: Colors.white, size: 150),
    );
  }
}
