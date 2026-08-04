import 'dart:async';
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
  bool _shaderCompilationFailed = false;

  @override
  void initState() {
    super.initState();
    _initAetherCorePipeline();
  }

  Future<void> _initAetherCorePipeline() async {
    // FIXED: Corrected path call targeting the unified assets bundle directory
    final Future<ui.FragmentProgram> shaderLoader = 
        ui.FragmentProgram.fromAsset('assets/shaders/hologram_glow.frag');
    
    try {
      final program = await shaderLoader.timeout(
        const Duration(seconds: 3),
        onTimeout: () => throw TimeoutException("GPU Shader Compilation Timeout"),
      );

      if (_isDisposed) return;

      setState(() {
        _program = program;
      });

      // Synchronize timeline calculations with native display refresh grids
      _syncTicker = createTicker((Duration elapsed) {
        if (!mounted) return;
        setState(() {
          _elapsedTime = elapsed.inMicroseconds / Duration.microsecondsPerSecond;
        });
      });
      _syncTicker!.start();
    } catch (e) {
      debugPrint('⚠️ [AetherCore Pro] Falling back to standard rendering stream: $e');
      if (mounted) {
        setState(() {
          _shaderCompilationFailed = true;
        });
      }
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
    final videoValue = widget.renderer.value;
    final double computedAspectRatio = videoValue.aspectRatio > 0 ? videoValue.aspectRatio : 9 / 16;

    // Handle early loading states cleanly before native surface textures activate
    if (_program == null && !_shaderCompilationFailed && widget.renderer.textureId == null) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00F3FF)),
        ),
      );
    }

    return Container(
      color: Colors.black,
      child: Center(
        child: AspectRatio(
          aspectRatio: computedAspectRatio,
          child: Stack(
            children: [
              // LAYER 1: Native WebRTC Video Hardware Decoder Engine
              Positioned.fill(
                child: RTCVideoView(
                  widget.renderer,
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  mirror: true,
                ),
              ),

              // LAYER 2: Post-Processing Shader Matrix (Draws the Neon Cyan glitch overlay)
              if (_program != null && !_shaderCompilationFailed)
                Positioned.fill(
                  child: CustomPaint(
                    key: ValueKey('aether_shader_overlay_${widget.renderer.textureId}'),
                    painter: AetherCoreOverlayPainter(
                      program: _program!,
                      time: _elapsedTime,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class AetherCoreOverlayPainter extends CustomPainter {
  final ui.FragmentProgram program;
  final double time;

  AetherCoreOverlayPainter({
    required this.program,
    required this.time,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final ui.FragmentShader shader = program.fragmentShader();

    // 1. Pass local size boundaries down to uniform floats 0 and 1
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);

    // 2. Pass high-frequency time metrics down to uniform float 2
    shader.setFloat(2, time);

    final Paint compositePaint = Paint()
      ..shader = shader
      ..blendMode = BlendMode.screen; // Clean mathematical pixel layer blending

    final Rect renderBoundaries = Offset.zero & size;
    canvas.drawRect(renderBoundaries, compositePaint);
  }

  @override
  bool shouldRepaint(covariant AetherCoreOverlayPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}
