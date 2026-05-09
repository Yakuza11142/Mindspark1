import 'package:flutter/material.dart';

class XpProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  const XpProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Level Progress", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.white10,
          color: Colors.cyanAccent,
          minHeight: 10,
          borderRadius: BorderRadius.circular(5),
        ),
      ],
    );
  }
}