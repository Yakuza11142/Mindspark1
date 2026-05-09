import 'package:flutter/material.dart';

class GlowAvatar extends StatelessWidget {
  final String? path;
  const GlowAvatar({super.key, this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: [Colors.cyan, Colors.purple])
      ),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.black,
        child: const Icon(Icons.person), // Replace with Image.file if path exists
      ),
    );
  }
}