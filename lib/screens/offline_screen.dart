import 'package:flutter/material.dart';

class OfflineScreen extends StatelessWidget {
  final VoidCallback onRetry;
  const OfflineScreen({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 80, color: Colors.red),
            const SizedBox(height: 20),
            const Text("No Connection", style: TextStyle(fontSize: 24)),
            ElevatedButton(onPressed: onRetry, child: const Text("Retry"))
          ],
        ),
      ),
    );
  }
}