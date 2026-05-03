import 'package:flutter/material.dart';
class ErrorBoundarySilent {
  static void secure() {
    ErrorWidget.builder = (details) => const SizedBox.shrink(); // Invisible fail
  }
}