import 'dart:convert';
import 'package:flutter/material.dart';
import '../data/offline_formula_images.dart';

class OfflineImageRenderer extends StatelessWidget {
  final String base64String;
  const OfflineImageRenderer({super.key, required this.base64String});

  @override
  Widget build(BuildContext context) {
    try {
      return Image.memory(
        base64Decode(base64String),
        fit: BoxFit.contain,
      );
    } catch (e) {
      return const Icon(Icons.broken_image, color: Colors.grey);
    }
  }
}