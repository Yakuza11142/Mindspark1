import 'package:flutter/services.dart';

class ClipboardService {
  static void copy(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}