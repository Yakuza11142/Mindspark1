import 'dart:async';
import 'package:flutter/material.dart';

class CbtGlobalMonitor extends WidgetsBindingObserver {
  // Singleton instance
  static final CbtGlobalMonitor instance = CbtGlobalMonitor._();
  CbtGlobalMonitor._();

  int _penalty = 0;
  // This stream allows every widget to "listen" to the penalty infinitely
  final _penaltyStream = StreamController<int>.broadcast();
  Stream<int> get penaltyStream => _penaltyStream.stream;

  void init() => WidgetsBinding.instance.addObserver(this);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Detects when they leave for Games, Calls, or Browsers
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      _penalty += 60; // Deduct 1 minute infinitely for ANY exit
      _penaltyStream.add(_penalty);
      debugPrint("🚨 Global Exit Detected: -1 Min Penalty Applied.");
    }
  }
}
