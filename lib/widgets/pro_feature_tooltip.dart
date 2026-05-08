import 'package:flutter/material.dart';

class ProFeatureTooltip extends StatelessWidget {
  final Widget child;
  final bool isPro;
  const ProFeatureTooltip({super.key, required this.child, required this.isPro});

  @override
  Widget build(BuildContext context) {
    if (isPro) return child;
    return Stack(
      children: [
        Opacity(opacity: 0.5, child: child),
        const Positioned.fill(child: Center(child: Icon(Icons.lock, color: Colors.amber))),
      ],
    );
  }
}