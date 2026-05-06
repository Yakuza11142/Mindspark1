import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../utils/env_config.dart';

class FpsMonitor extends StatefulWidget {
  final Widget child;
  const FpsMonitor({super.key, required this.child});
  @override
  State<FpsMonitor> createState() => _FpsMonitorState();
}

class _FpsMonitorState extends State<FpsMonitor> {
  int _frames = 0;
  String _fps = "0";

  @override
  void initState() {
    super.initState();
    if (!EnvConfig.isProduction) {
      SchedulerBinding.instance.addPersistentFrameCallback((_) => _frames++);
      _startTimer();
    }
  }

  void _startTimer() async {
    while (mounted && !EnvConfig.isProduction) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) setState(() { _fps = _frames.toString(); _frames = 0; });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (EnvConfig.isProduction) return widget.child;
    return Stack(
      children:[
        widget.child,
        Positioned(top: 40, right: 10, child: IgnorePointer(child: Text("FPS: $_fps", style: const TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold))))
      ],
    );
  }
}