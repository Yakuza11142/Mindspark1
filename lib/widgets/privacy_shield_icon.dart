import 'package:flutter/material.dart';

class PrivacyShieldIcon extends StatelessWidget {
  final bool isAdult;
  const PrivacyShieldIcon({super.key, required this.isAdult});
  @override
  Widget build(BuildContext context) {
    if (isAdult) return const Tooltip(message: "18+ Privacy Active", child: Icon(Icons.lock_person, size: 12, color: Colors.green));
    return const SizedBox.shrink();
  }
}