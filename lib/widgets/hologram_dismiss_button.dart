import 'package:flutter/material.dart';

class HologramDismissButton extends StatelessWidget {
  final VoidCallback onDismiss;
  const HologramDismissButton({super.key, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.red,
      onPressed: onDismiss,
      child: const Icon(Icons.close, color: Colors.white),
    );
  }
}