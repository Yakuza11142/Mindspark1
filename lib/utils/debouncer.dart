import 'dart:async';
import 'package:flutter/material.dart';

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    // 1. Clears out any active timer thread instantly using clean conditional execution
    _timer?.cancel();
    
    // 2. Starts the new action cooldown thread safely
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  // 3. CRUCIAL: Call this method in your stateful widget's dispose() to prevent background memory leaks
  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
