import 'dart:ui';
import 'package:flutter/material.dart';

class ProFeatureGuard extends StatelessWidget {
  final bool isPro;
  final Widget child;
  final VoidCallback onUnlock;

  const ProFeatureGuard({super.key, required this.isPro, required this.child, required this.onUnlock});

  @override
  Widget build(BuildContext context) {
    if (isPro) return child;
    return Stack(
      children: [
        ImageFiltered(imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), child: child),
        Positioned.fill(
          child: Center(
            child: ElevatedButton.icon(
              onPressed: onUnlock,
              icon: const Icon(Icons.lock),
              label: const Text("Unlock"),
            ),
          ),
        )
      ],
    );
  }
}