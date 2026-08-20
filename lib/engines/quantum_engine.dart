import 'package:flutter/material.dart';
import 'dart:math' as m;

class C {
  final double r, i;
  const C(this.r, this.i);
  C operator +(C o) => C(r + o.r, i + o.i);
  C operator *(C o) => C(r * o.r - i * o.i, r * o.i + i * o.r);
}

class DQMatrix {
  late List<C> st; int q, dim;
  DQMatrix({this.q = 2}) : dim = 1 << q {
    st = List.generate(dim, (i) => i == 0 ? const C(1, 0) : const C(0, 0));
  }

  List<C> _kr(List<C> m1, int r1, List<C> m2, int r2) {
    var res = List.filled((r1 * r2) * (r1 * r2), const C(0, 0));
    for (int i = 0; i < r1; i++) {
      for (int j = 0; j < r1; j++) {
        for (int k = 0; k < r2; k++) {
          for (int l = 0; l < r2; l++) {
            res[(i * r2 + k) * (r1 * r2) + (j * r2 + l)] = m1[i * r1 + j] * m2[k * r2 + l];
          }
        }
      }
    }
    return res;
  }

  void _ev(List<C> op) {
    st = List.generate(dim, (i) {
      C sum = const C(0, 0);
      for (int j = 0; j < dim; j++) {
        sum = sum + (op[i * dim + j] * st[j]);
      }
      return sum;
    });
  }

  List<C> _bOp(List<C> g, int t) {
    var id = [const C(1, 0), const C(0, 0), const C(0, 0), const C(1, 0)];
    var op = (t == 0) ? g : id;
    for (int i = 1; i < q; i++) {
      op = _kr(op, 1 << i, (i == t) ? g : id, 2);
    }
    return op;
  }

  void h(int t) => _ev(_bOp([C(1/m.sqrt(2), 0), C(1/m.sqrt(2), 0), C(1/m.sqrt(2), 0), C(-1/m.sqrt(2), 0)], t));

  void cnot(int c, int tg) {
    _ev(List.generate(dim * dim, (idx) {
      int r = idx ~/ dim, col = idx % dim;
      return (col == ((((r >> (q - 1 - c)) & 1) == 1) ? r ^ (1 << (q - 1 - tg)) : r)) ? const C(1, 0) : const C(0, 0);
    }));
  }

  void phase(int t, double th) => _ev(_bOp([const C(1, 0), const C(0, 0), const C(0, 0), C(m.cos(th), m.sin(th))], t));
  List<double> get p => st.map((c) => c.r * c.r + c.i * c.i).toList();
}

class NDimEng {
  final int d; late List<List<double>> v; final List<List<int>> e = [];
  NDimEng({this.d = 4}) {
    int total = 1 << d;
    v = List.generate(total, (i) => List.generate(d, (j) => ((i >> j) & 1) == 1 ? 1.0 : -1.0));
    for (int i = 0; i < total; i++) {
      for (int j = i + 1; j < total; j++) {
        if (List.generate(d, (k) => v[i][k] == v[j][k] ? 0 : 1).reduce((a, b) => a + b) == 1) e.add([i, j]);
      }
    }
  }

  List<List<double>> proj(double t, double p) {
    return v.map((vt) {
      // 🚀 FIXED VECTOR ALIGNMENT: Explicitly indexes multi-dimensional arrays [0..3]
      double x = vt[0] * m.cos(t) - vt[1] * m.sin(t), w = vt[3] * m.sin(t) + vt[2] * m.cos(t);
      double y = vt[1] * m.cos(p) - vt[0] * m.sin(p), z = vt[2] * m.sin(p) + vt[3] * m.cos(p);
      return [x / (3.0 - w), y / (3.0 - w), z / (3.0 - w)];
    }).toList();
  }
}

void main() => runApp(const MaterialApp(home: App(), debugShowCheckedModeBanner: false));

class App extends StatefulWidget { const App({super.key}); @override State<App> createState() => _AppState(); }
class _AppState extends State<App> with SingleTickerProviderStateMixin {
  final q = DQMatrix()..h(0)..cnot(0, 1); final eng = NDimEng(); late AnimationController ctrl; double ph = 0.0, ai = 0.5;
  @override void initState() { super.initState(); ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat(); }
  @override void dispose() { ctrl.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFF05050A), body: SafeArea(child: Column(children: [
      Expanded(child: AnimatedBuilder(animation: ctrl, builder: (c, _) {
        double b = 0.0, t = ctrl.value * 2 * m.pi + ph;
        for (int i = 0; i < q.p.length; i++) { b += q.p[i] * (i + 1); }
        return CustomPaint(painter: Pnt(eng.proj(t, t * ai + b), eng.e), child: Container());
      })),
      Container(padding: const EdgeInsets.all(16), color: const Color(0xFF0F0F1A), child: Column(children: [
        Row(children: [const Text("AI State", style: TextStyle(color: Colors.white)), Expanded(child: Slider(value: ai, onChanged: (v) => setState(() => ai = v)))]),
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => setState(() { ph += m.pi / 4; q.phase(1, m.pi / 4); }), child: const Text("P2P Phase Sync")))
      ]))
    ])));
  }
}

class Pnt extends CustomPainter {
  final List<List<double>> v; final List<List<int>> e; Pnt(this.v, this.e);
  @override void paint(Canvas cv, Size sz) {
    final c = Offset(sz.width / 2, sz.height / 2), sc = sz.width * 0.45;
    // 🚀 FIXED GEOMETRIC TRANSLATION: Indexes into coordinates cleanly to execute lines
    final d2 = v.map((p) => Offset(c.dx + p[0] * sc / (2.5 - p[2]), c.dy + p[1] * sc / (2.5 - p[2]))).toList();
    for (var edge in e) { cv.drawLine(d2[edge[0]], d2[edge[1]], Paint()..color = Colors.cyan.withOpacity(0.8)..strokeWidth = 1.5); }
    for (var pt in d2) { cv.drawCircle(pt, 3.5, Paint()..color = Colors.magentaAccent); }
  }
  @override bool shouldRepaint(covariant Pnt old) => true;
}