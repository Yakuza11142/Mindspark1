import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class HolographicText extends StatefulWidget {
  final String text;
  const HolographicText({super.key, required this.text});

  @override
  State<HolographicText> createState() => _HolographicTextState();
}

class _HolographicTextState extends State<HolographicText> {
  double _tilt = 0;

  @override
  void initState() {
    super.initState();
    gyroscopeEvents.listen((event) {
      if (mounted) setState(() => _tilt = event.y);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: const[Colors.cyan, Colors.purple, Colors.amber],
        stops:[0.0, 0.5 + (_tilt * 0.1), 1.0], // Moves gradient based on tilt
      ).createShader(bounds),
      child: Text(widget.text, style: const TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}