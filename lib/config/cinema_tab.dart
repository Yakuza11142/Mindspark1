import 'package:flutter/material.dart';

class CinemaTab extends StatelessWidget {
  const CinemaTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cinema")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.movie, size: 80, color: Colors.cyan),
            const SizedBox(height: 20),
            const Text("Video Learning Hub"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Browse Videos"),
            ),
          ],
        ),
      ),
    );
  }
}
