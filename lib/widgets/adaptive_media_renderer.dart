import 'package:flutter/material.dart';
import '../engines/hardware_capability_engine.dart';
import '../screens/holo_deck_screen.dart';
import 'dynamic_2d_fallback_renderer.dart';

class AdaptiveMediaRenderer extends StatelessWidget {
  final String topic;
  final bool isPro;
  const AdaptiveMediaRenderer({super.key, required this.topic, required this.isPro});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: HardwareCapabilityEngine.supports3D(),
      builder: (ctx, snap) {
        bool canRun3D = snap.data ?? false;

        if (isPro && canRun3D) {
          return HoloDeckScreen(topic: topic); // Full 3D AR
        } else {
          return Dynamic2dFallbackRenderer(topic: topic); // Safe 2D Fallback
        }
      },
    );
  }
}