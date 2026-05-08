import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClipboardToast {
  static void copy(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Copied to Clipboard")));
  }
}