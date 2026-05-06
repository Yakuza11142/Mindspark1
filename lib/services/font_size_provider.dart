import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontSizeProvider extends ChangeNotifier {
  double _scale = 1.0;
  double get scale => _scale;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _scale = prefs.getDouble('font_scale') ?? 1.0;
    notifyListeners();
  }

  void updateScale(double newScale) async {
    _scale = newScale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('font_scale', newScale);
  }
}