import 'package:flutter/material.dart';
import 'dart:math';

class SkillRadarChart extends StatelessWidget {
  final Map<String, double> skills; // e.g. {"Math": 0.8, "Physics": 0.5}
  
  const SkillRadarChart({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, width: 200,
      child: CustomPaint(painter: _RadarPainter(skills)),
    );
  }
}

class _RadarPainter extends CustomPainter {
  final Map<String, double> skills;
  _RadarPainter(this.skills);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()..color = Colors.cyanAccent.withOpacity(0.5)..style = PaintingStyle.fill;
    final linePaint = Paint()..color = Colors.white24..style = PaintingStyle.stroke;

    final path = Path();
    final keys = skills.keys.toList();
    final angleStep = (2 * pi) / keys.length;

    for (int i = 0; i < keys.length; i++) {
      final value = skills[keys[i]]!;
      final angle = i * angleStep - (pi / 2);
      final x = center.dx + radius * value * cos(angle);
      final y = center.dy + radius * value * sin(angle);
      if (i == 0) path.moveTo(x, y);
      else path.lineTo(x, y);
      
      // Draw Grid Lines
      canvas.drawLine(center, Offset(center.dx + radius * cos(angle), center.dy + radius * sin(angle)), linePaint);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}