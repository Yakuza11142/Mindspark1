import 'package:flutter/material.dart';

void showCustomSnack(BuildContext context, String text, {bool success = true}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: success ? const Color(0xFF0F172A) : Colors.red,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: success ? Colors.cyan : Colors.red)),
      content: Text(text, style: const TextStyle(color: Colors.white)),
    )
  );
}