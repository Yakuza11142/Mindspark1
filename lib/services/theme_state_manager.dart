import 'package:flutter/material.dart';
class ThemeStateManager extends ChangeNotifier {
  final ThemeMode _mode = ThemeMode.dark; // Hardcoded to dark mode per CEO
  ThemeMode get mode => _mode;
}