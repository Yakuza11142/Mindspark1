import 'package:flutter/material.dart';

void showError(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text("System Error"),
      content: Text(message),
      actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("OK"))],
    ),
  );
}