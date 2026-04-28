import 'package:flutter/material.dart';

class AhColorPalette {
  static const Color sparkCyan = Color(0xFF00FFFF);
  static const Color nexusPurple = Color(0xFF6A0DAD);
  static const Color ariaGold = Color(0xFFFFBF00);

  static Color getColorForAh(String name) {
    if (name == "Nexus") return nexusPurple;
    if (name == "Aria") return ariaGold;
    return sparkCyan; // Default to Spark
  }
}