import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  Color _accent = Colors.cyanAccent;
  Color get accent => _accent;
  
  void setAccent(Color c) {
    _accent = c;
    notifyListeners();
  }
}