import 'package:flutter/material.dart';

class JambAuthenticTheme {
  static ThemeData get cbtTheme => ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color(0xFF006600), // JAMB Green
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF006600), foregroundColor: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF006600),
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero), // No rounded corners in 2010 software
      )
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Times New Roman'), // Authentic CBT font
    )
  );
}