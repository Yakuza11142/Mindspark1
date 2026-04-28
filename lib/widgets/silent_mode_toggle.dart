import 'package:flutter/material.dart';
import '../services/sound_manager.dart'; // Handles global mute

class SilentModeToggle extends StatefulWidget {
  const SilentModeToggle({super.key});
  @override
  State<SilentModeToggle> createState() => _SilentModeToggleState();
}

class _SilentModeToggleState extends State<SilentModeToggle> {
  bool isMuted = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isHovered ? Icons.volume_off : Icons.volume_up, color: Colors.amber),
      onPressed: () {
        setState(() => isMuted = !isMuted);
        SoundManager.toggleMute();
      },
    );
  }
}