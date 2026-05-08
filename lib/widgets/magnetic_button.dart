import 'package:flutter/material.dart';

class MagneticButton extends StatefulWidget {
  final Widget child;
  const MagneticButton({super.key, required this.child});
  @override
  State<MagneticButton> createState() => _MagneticButtonState();
}

class _MagneticButtonState extends State<MagneticButton> {
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {},
      onExit: (_) => setState(() => _offset = Offset.zero),
      onHover: (e) => setState(() => _offset = (e.localPosition - const Offset(50, 20)) / 5),
      child: Transform.translate(offset: _offset, child: widget.child),
    );
  }
}