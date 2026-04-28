import 'package:flutter/material.dart';
import '../config/ah_color_palette.dart';

class AhChatBackground extends StatelessWidget {
  final String ahName;
  final Widget child;

  const AhChatBackground({super.key, required this.ahName, required this.child});

  @override
  Widget build(BuildContext context) {
    Color glowColor = AhColorPalette.getColorForAh(ahName);

    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topRight,
          radius: 1.5,
          colors:[
            glowColor.withOpacity(0.15), // Soft glow of the character's color
            const Color(0xFF050505), // Pitch black
          ],
        )
      ),
      child: child,
    );
  }
}