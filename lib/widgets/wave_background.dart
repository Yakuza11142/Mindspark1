import 'package:flutter/material.dart';
import 'dart:math' as math;

class WaveBackground extends StatefulWidget {
  final Widget? child;

  const WaveBackground({
    super.key,
    this.child,
  });

  @override
  State<WaveBackground> createState() => _WaveBackgroundState();
}

class _WaveBackgroundState extends State<WaveBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8), // Slower speed feels more natural for filled waves
      vsync: this,
    )..repeat(); 
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0F172A), // Slate 900
            Color(0xFF1E293B), // Slate 800
          ],
        ),
      ),
      width: double.infinity,
      height: double.infinity,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: ParallaxWavePainter(animationValue: _controller.value),
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}

class ParallaxWavePainter extends CustomPainter {
  final double animationValue;

  ParallaxWavePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final midHeight = size.height * 0.6; 
    final waveAmplitude = size.height * 0.05;

    // Wave 1: Cyan Fill (Background Wave)
    // FIXED: Swapped out deprecated withOpacity for modern withValues alpha layers
    final paint1 = Paint()
      ..color = const Color(0xFF38BDF8).withValues(alpha: 0.08)
      ..style = PaintingStyle.fill; 

    _drawSineWave(canvas, size, paint1, midHeight, waveAmplitude, animationValue * 2 * math.pi, 1.2, isFilled: true);

    // Wave 2: Indigo Fill (Foreground Wave)
    // FIXED: Swapped out deprecated withOpacity for modern withValues alpha layers
    final paint2 = Paint()
      ..color = const Color(0xFF818CF8).withValues(alpha: 0.12)
      ..style = PaintingStyle.fill; 

    _drawSineWave(canvas, size, paint2, midHeight * 1.03, waveAmplitude * 0.7, -animationValue * 2 * math.pi, 1.8, isFilled: true);
  }

  void _drawSineWave(Canvas canvas, Size size, Paint paint, double midHeight, double amplitude, double phase, double frequency, {required bool isFilled}) {
    final path = Path();

    for (double x = 0; x <= size.width; x += 6) {
      final relativeX = (x / size.width) * 2 * math.pi * frequency; 
      final y = midHeight + math.sin(relativeX + phase) * amplitude;

      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    if (isFilled) {
      path.lineTo(size.width, size.height); 
      path.lineTo(0, size.height);          
      path.close();                         
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ParallaxWavePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
