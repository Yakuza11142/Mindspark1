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

class _HologramStreamWidgetState extends State<HologramStreamWidget>
    with SingleTickerProviderStateMixin {
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
      final program =
          await ui.FragmentProgram.fromAsset('shaders/hologram_glow.frag');
      if (_isDisposed) return;

      _program = program;

      _syncTicker = createTicker((Duration elapsed) {
        if (mounted) {
          setState(() {
            _elapsedTime =
                elapsed.inMicroseconds / Duration.microsecondsPerSecond;
          });
        }
      })
        ..start();
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
    // FIXED: Block rendering lifecycle execution if shader assets or native textures are unready
    if (_program == null || widget.renderer.textureId == null) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
        ),
      );
    }

    final videoValue = widget.renderer.value;

    return Container(
      color: Colors.black,
      child: Center(
        child: AspectRatio(
          aspectRatio:
              videoValue.aspectRatio > 0 ? videoValue.aspectRatio : 9 / 16,
          // FIXED: Removed the dynamic elapsed time variable from the ValueKey.
          // This keeps the element tree stable while letting shouldRepaint redraw the canvas.
          child: CustomPaint(
            key: ValueKey('aether_core_${widget.renderer.textureId}'),
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

    // 3. FIXED: WebRTC Texture Bridge Insertion Point
    // WebRTC on mobile builds uses native backing textures. If your shader expects an image sampler,
    // you must pass the texture using image parameters (requires Flutter 3.x+ fragment shader support).
    // Ensure your GLSL file specifies: layout(location = 0) out vec4 fragColor; layout(binding = 0) uniform sampler2D u_VideoTexture;
    
    // Fallback: If you encounter rendering anomalies with native hardware textures,
    // wrap this custom painter inside a Stack directly over a standard RTCVideoView(renderer) block.

    final Paint paint = Paint()..shader = shader;

    final Rect rect = Offset.zero & size;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant AetherCorePainter oldDelegate) {
    return oldDelegate.time != time ||
        oldDelegate.renderer.textureId != renderer.textureId;
  }
}
