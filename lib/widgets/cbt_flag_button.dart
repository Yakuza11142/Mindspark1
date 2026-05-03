import 'package:flutter/material.dart';

class CbtFlagButton extends StatefulWidget {
  final bool isFlagged;
  final VoidCallback onToggle;
  const CbtFlagButton({super.key, required this.isFlagged, required this.onToggle});

  @override
  State<CbtFlagButton> createState() => _CbtFlagButtonState();
}

class _CbtFlagButtonState extends State<CbtFlagButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(widget.isFlagged ? Icons.flag : Icons.outlined_flag, color: widget.isFlagged ? Colors.red : Colors.grey),
      onPressed: widget.onToggle,
      tooltip: "Flag for Review",
    );
  }
}