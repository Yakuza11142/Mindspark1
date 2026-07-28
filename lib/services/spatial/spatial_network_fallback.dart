import 'dart:async';
import 'package:flutter/material.dart';

enum TrackingState { streamingCloud, localFallback, networkOffline }

class SpatialNetworkGuard extends ChangeNotifier {
  TrackingState _currentState = TrackingState.streamingCloud;
  double _currentPingMs = 0.0;
  Timer? _latencyCheckLoop;

  // 🚀 CRITICAL THRESHOLD: If server loop takes over 180ms, switch to local processing instantly
  final double maxAllowedLatencyMs = 180.0;

  TrackingState get currentState => _currentState;
  double get currentPingMs => _currentPingMs;

  void initializeLatencyGuard() {
    _latencyCheckLoop = Timer.periodic(const Duration(seconds: 2), (timer) {
      _evaluateNetworkPipeline();
    });
  }

  void reportFrameDeliveryMetrics(double latencyMs) {
    _currentPingMs = latencyMs;
    _evaluateNetworkPipeline();
  }

  void _evaluateNetworkPipeline() {
    if (_currentPingMs == 0.0) {
      _updateState(TrackingState.networkOffline);
      return;
    }

    if (_currentPingMs > maxAllowedLatencyMs) {
      if (_currentState != TrackingState.localFallback) {
        debugPrint("⚠️ High Latency Detected (${_currentPingMs}ms). Diverting vector calculations to local Edge engine.");
        _updateState(TrackingState.localFallback);
      }
    } else {
      if (_currentState != TrackingState.streamingCloud) {
        debugPrint("🚀 Connection Stable (${_currentPingMs}ms). Reconnecting to high-fidelity remote NVIDIA clusters.");
        _currentState = TrackingState.streamingCloud;
        notifyListeners();
      }
    }
  }

  void _updateState(TrackingState newState) {
    if (_currentState != newState) {
      _currentState = newState;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _latencyCheckLoop?.cancel();
    super.dispose();
  }
}
