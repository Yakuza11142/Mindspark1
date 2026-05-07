import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class WhatsappStatusExporter extends StatelessWidget {
  final int score;
  const WhatsappStatusExporter({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.camera_alt, color: Colors.green),
      onPressed: () {
        Share.share("I just scored $score% on the MindSpark AI Simulator! 🧠🚀 Can you beat me? mindspark.app");
      },
    );
  }
}