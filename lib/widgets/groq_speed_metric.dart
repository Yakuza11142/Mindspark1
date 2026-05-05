import 'package:flutter/material.dart';

class GroqSpeedMetric extends StatelessWidget {
  final int timeMs;
  final bool isPro;
  const GroqSpeedMetric({super.key, required this.timeMs, required this.isPro});

  @override
  Widget build(BuildContext context) {
    if (timeMs == 0) return const SizedBox.shrink();
    
    double seconds = timeMs / 1000;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: isPro ? Colors.purpleAccent : Colors.cyanAccent)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children:[
          const Icon(Icons.flash_on, color: Colors.amber, size: 14),
          const SizedBox(width: 5),
          Text(
            "Generated in ${seconds.toStringAsFixed(2)}s via LPU", 
            style: const TextStyle(color: Colors.white70, fontSize: 10, fontFamily: 'monospace')
          ),
        ],
      ),
    );
  }
}