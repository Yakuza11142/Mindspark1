import 'package:flutter/material.dart';
class ArResetButton extends StatelessWidget {
  const ArResetButton({super.key});
  @override
  Widget build(BuildContext context) => IconButton(icon: const Icon(Icons.refresh, color: Colors.white), onPressed: () => print("Resetting AR Anchor."));
}