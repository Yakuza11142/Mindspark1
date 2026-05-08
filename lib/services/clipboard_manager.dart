import 'package:flutter/services.dart';

class ClipboardManager {
  static void copy(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}