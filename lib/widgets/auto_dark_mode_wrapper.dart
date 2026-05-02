import 'package:flutter/material.dart';
import '../hardware/ambient_light_reader.dart';

class AutoDarkModeWrapper extends StatefulWidget {
  final Widget child;
  const AutoDarkModeWrapper({super.key, required this.child});

  @override
  State<AutoDarkModeWrapper> createState() => _AutoDarkModeWrapperState();
}

class _AutoDarkModeWrapperState extends State<AutoDarkModeWrapper> {
  bool _isVeryDark = false;

  @override
  void initState() {
    super.initState();
    AmbientLightReader.listenForDarkness((isDark) {
      if (mounted && _isVeryDark != isDark) {
        setState(() => _isVeryDark = isDark);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _isVeryDark ? 0.7 : 1.0, // Dims the entire screen slightly in pitch black rooms
      child: widget.child,
    );
  }
}