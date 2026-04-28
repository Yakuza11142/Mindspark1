import 'dart:math';
import 'dart:async';

class MicroExpressionGenerator {
  static void startBlinkingRoutine() {
    // Humans blink randomly every 3 to 7 seconds
    Timer.periodic(Duration(seconds: Random().nextInt(4) + 3), (timer) {
      print("👁️ Triggering Blink Blendshape on 3D Model.");
    });
  }
}