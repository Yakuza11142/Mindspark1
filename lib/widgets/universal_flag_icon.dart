import 'package:flutter/material.dart';

class UniversalFlagIcon extends StatelessWidget {
  final String countryCode; // e.g., 'US', 'NG', 'GB'
  const UniversalFlagIcon({super.key, required this.countryCode});

  @override
  Widget build(BuildContext context) {
    // Converts ISO country code to Unicode Flag Emoji
    int flagOffset = 0x1F1E6;
    int asciiOffset = 0x41;
    String flag = String.fromCharCode(countryCode.codeUnitAt(0) - asciiOffset + flagOffset) +
                  String.fromCharCode(countryCode.codeUnitAt(1) - asciiOffset + flagOffset);
    return Text(flag, style: const TextStyle(fontSize: 20));
  }
}