import 'package:flutter/material.dart';

class AiAvatarWidget extends StatelessWidget {
  const AiAvatarWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, height: 100,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: [Colors.blue, Colors.purple])
      ),
      child: const Icon(Icons.smart_toy, size: 50, color: Colors.white),
    );
  }
}