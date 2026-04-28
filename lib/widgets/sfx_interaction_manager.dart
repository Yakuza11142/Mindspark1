import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class SfxButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  
  const SfxButton({super.key, required this.child, required this.onTap});

  static final AudioPlayer _sfxPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Play Sci-Fi Click Sound
        await _sfxPlayer.play(AssetSource('sounds/ui_hologram_click.mp3'), volume: 0.8);
        // Vibrate
        HapticFeedback.lightImpact();
        // Execute Action
        onTap();
      },
      child: child,
    );
  }
}