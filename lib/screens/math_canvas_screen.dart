import 'package:flutter/material.dart';
// Add painter package or use CustomPaint logic
class MathCanvasScreen extends StatefulWidget {
  const MathCanvasScreen({super.key});
  @override
  State<MathCanvasScreen> createState() => _MathCanvasScreenState();
}

class _MathCanvasScreenState extends State<MathCanvasScreen> {
  List<Offset?> points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Draw Equation"), actions: [
        IconButton(icon: const Icon(Icons.check), onPressed: () {
          // Send drawing to Gemini Vision API
        })
      ]),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            points.add(renderBox.globalToLocal(details.globalPosition));
          });
        },
        onPanEnd: (details) => points.add(null),
        child: CustomPaint(
          painter: _SketchPainter(points),
          size: Size.infinite,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => points.clear()),
        child: const Icon(Icons.clear),
      ),
    );
  }
}

class _SketchPainter extends CustomPainter {
  final List<Offset?> points;
  _SketchPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white..strokeCap = StrokeCap.round..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}