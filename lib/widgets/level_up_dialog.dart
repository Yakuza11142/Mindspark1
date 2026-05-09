import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LevelUpDialog extends StatelessWidget {
  final int newLevel;
  const LevelUpDialog({super.key, required this.newLevel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.arrow_circle_up, size: 100, color: Colors.cyanAccent)
              .animate().scale(duration: 500.ms).then().shimmer(),
          Text("LEVEL $newLevel", style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("AWESOME"))
        ],
      ),
    );
  }
}