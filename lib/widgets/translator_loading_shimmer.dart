import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GlobalLoadingShimmer extends StatelessWidget {
  final String message;
  final double fontSize;
  final TextAlign textAlign;

  // Global Brand Colors
  static const Color baseColor = Colors.white10;
  static const Color highlightColor = Colors.cyanAccent;

  const GlobalLoadingShimmer({
    super.key, 
    required this.message, 
    this.fontSize = 18.0,
    this.textAlign = TextAlign.center, // Added for global alignment control
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor.withOpacity(0.5),
      period: const Duration(milliseconds: 1500), // Standardized global speed
      child: Text(
        message,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize, 
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto', // Ensures consistent look globally
        ),
      ),
    );
  }
}
