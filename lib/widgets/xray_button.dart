import 'package:flutter/material.dart';

class XrayButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isPro;
  const XrayButton({super.key, required this.onTap, required this.isPro});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onTap,
      label: Text(isPro ? "X-RAY ACTIVE" : "UNLOCK X-RAY"),
      icon: const Icon(Icons.layers),
      backgroundColor: isPro ? Colors.green : Colors.grey,
    );
  }
}