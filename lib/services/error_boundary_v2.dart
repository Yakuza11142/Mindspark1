import 'package:flutter/material.dart';

class ErrorBoundaryV2 {
  static void secureStage() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return const Center(
        child: Text("Processing Data...", style: TextStyle(color: Colors.amber, fontSize: 16)),
      );
    };
  }
}