import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontSizeSlider extends StatefulWidget {
  final Function(double) onChanged;
  const FontSizeSlider({super.key, required this.onChanged});

  @override
  State<FontSizeSlider> createState() => _FontSizeSliderState();
}

class _FontSizeSliderState extends State<FontSizeSlider> {
  double _size = 16.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Text Size", style: TextStyle(color: Colors.white)),
        Slider(
          value: _size,
          min: 12.0,
          max: 30.0,
          activeColor: Colors.cyanAccent,
          onChanged: (val) {
            setState(() => _size = val);
            widget.onChanged(val);
            SharedPreferences.getInstance().then((p) => p.setDouble('font_size', val));
          },
        ),
      ],
    );
  }
}