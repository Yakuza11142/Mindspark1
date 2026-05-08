import 'package:flutter/material.dart';
import '../services/clipboard_service.dart';

class CopyButton extends StatelessWidget {
  final String text;
  const CopyButton({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.copy),
      onPressed: () {
        ClipboardService.copy(text);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Copied!")));
      },
    );
  }
}