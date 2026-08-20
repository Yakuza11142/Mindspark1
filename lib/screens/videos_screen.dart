import 'package:flutter/material.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Videos')),
      body: const Center(
        child: Text(
          'Educational Videos',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
