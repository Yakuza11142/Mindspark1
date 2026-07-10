import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class HologramStreamWidget extends StatefulWidget {
  final RTCVideoRenderer renderer;
  const HologramStreamWidget({super.key, required this.renderer});

  @override
  State<HologramStreamWidget> createState() => _HologramStreamWidgetState();
}

class _HologramStreamWidgetState extends State<HologramStreamWidget> with SingleTickerProviderStateMixin {
  ui.FragmentProgram? _program;
  Ticker? _syncTicker;
  double _elapsedTime = 0.0;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _initAetherCorePipeline();
  }

  Future<void> _initAetherCorePipeline() async {
    try {
      final program = await ui.FragmentProgram.fromAsset('shaders/hologram_glow.frag');
      if (_isDisposed) return;
      
      _program = program;
      
      // Ignite ultra-low-latency 120Hz frame-synchronized hardware ticker
      _syncTicker = createTicker((Duration elapsed) {
        if (mounted) {
          setState(() {
            _elapsedTime = elapsed.inMicroseconds / Duration.microsecondsPerSecond;
          });
        }
      })..start();
    } catch (e) {
      debugPrint('❌ [AetherCore Pro] Initialization Failure: $e');
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _syncTicker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_program == null) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
        ),
      );
    }

    // Capture the active WebRTC engine renderer state context
    final videoValue = widget.renderer.value;

    return Container(
      color: Colors.black,
      child: Center(
        child: AspectRatio(
          aspectRatio: videoValue.aspectRatio > 0 ? videoValue.aspectRatio : 9 / 16,
          child: CustomPaint(
            key: ValueKey('aether_core_${widget.renderer.textureId}_$_elapsedTime'),
            painter: AetherCorePainter(
              program: _program!,
              renderer: widget.renderer,
              time: _elapsedTime,
            ),
          ),
        ),
      ),
    );
  }
}

class AetherCorePainter extends CustomPainter {
  final ui.FragmentProgram program;
  final RTCVideoRenderer renderer;
  final double time;

  AetherCorePainter({
    required this.program,
    required this.renderer,
    required this.time,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final ui.FragmentShader shader = program.fragmentShader();

    // 1. Pass dimensional scaling constants to secure crisp 6ft projection edges
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    
    // 2. Pass the high-frequency clock signal for fluid glitch effects
    shader.setFloat(2, time);

    final Paint paint = Paint()..shader = shader;

    // 3. Clear canvas and blit the raw matrix boundaries instantly
    final Rect rect = Offset.zero & size;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant AetherCorePainter oldDelegate) {
    return oldDelegate.time != time || oldDelegate.renderer.textureId != renderer.textureId;
  }
}
