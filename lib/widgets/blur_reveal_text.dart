import 'dart:ui';
import 'package:flutter/material.dart';

class BlurRevealText extends StatefulWidget {
  final String text;
  const BlurRevealText({super.key, required this.text});

  @override
  State<BlurRevealText> createState() => _BlurRevealTextState();
}

class _BlurRevealTextState extends State<BlurRevealText> {
  bool isRevealed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => isRevealed = true),
      child: Stack(
        alignment: Alignment.center,
        children:[
          Text(widget.text, style: const TextStyle(color: Colors.cyanAccent, fontSize: 18, fontWeight: FontWeight.bold)),
          if (!isRevealed)
            Positioned.fill(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(color: Colors.black.withOpacity(0.5), alignment: Alignment.center, child: const Text("TAP TO REVEAL", style: TextStyle(fontSize: 10, color: Colors.white))),
                ),
              ),
            ),
        ],
      ),
    );
  }
}