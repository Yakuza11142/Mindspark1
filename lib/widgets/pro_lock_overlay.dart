import 'dart:ui';
import 'package:flutter/material.dart';

class ProLockOverlay extends StatelessWidget {
  final VoidCallback onUnlock;
  const ProLockOverlay({super.key, required this.onUnlock});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.black.withOpacity(0.6),
          child: Center(
            child: ElevatedButton.icon(
              onPressed: onUnlock,
              icon: const Icon(Icons.lock),
              label: const Text("Pro Only"),
            ),
          ),
        ),
      ),
    );
  }
}