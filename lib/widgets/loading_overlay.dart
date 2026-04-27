import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: const Icon(Icons.bolt, size: 100, color: Colors.amber)
            .animate(onPlay: (c) => c.repeat()).shimmer(duration: 1000.ms),
      ),
    );
  }
}