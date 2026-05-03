import 'package:flutter/material.dart';

class NetworkRetryButton extends StatelessWidget {
  final VoidCallback onRetry;
  const NetworkRetryButton({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.refresh, color: Colors.black),
      label: const Text("Retry Connection", style: TextStyle(color: Colors.black)),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent),
      onPressed: onRetry,
    );
  }
}