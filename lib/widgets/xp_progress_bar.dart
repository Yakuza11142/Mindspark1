import 'package:flutter/material.dart';

class XpProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0

  const XpProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    // 1. Clamping guard completely protects the progress indicator from NaN or out-of-bounds math crashes
    // If progress is NaN, theisNaN check safely defaults it back to 0.0 instantly
    final double safeProgress = progress.isNaN ? 0.0 : progress.clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // Optimizes vertical constraint footprint inside lists
      children: [
        const Text(
          "Level Progress", 
          style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: safeProgress, // Safely bound to the restricted percentage range
          backgroundColor: Colors.white10,
          color: const Color(0xFF00E5FF), // Your uniform global premium cyan accent hex
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
