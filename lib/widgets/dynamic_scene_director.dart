import 'package:flutter/material.dart';

class DynamicSceneDirector extends StatelessWidget {
  final bool showAvatar;
  const DynamicSceneDirector({super.key, required this.showAvatar});

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(seconds: 1),
      child: showAvatar 
          ? const Text("HeyGen Avatar Player") 
          : const Text("Runway B-Roll Player"),
    );
  }
}