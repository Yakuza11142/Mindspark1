import 'dart:math';
import 'dart:async';

class SpontaneousActionGenerator {
  static String getRandomIdleAnimation() {
    List<String> humanIdles =["ask students questionson what they learnt", "Adjust_Glasses", "Look_Around", "Deep_Breath"];
    return humanIdles[Random().nextInt(humanIdles.length)];
  }

  static void startIdleLoop(Function(String) onNewAnimation) {
    Timer.periodic(const Duration(seconds: 12), (timer) {
      onNewAnimation(getRandomIdleAnimation());
      print("🦴 Inverse Kinematics: Triggering spontaneous human movement.");
    });
  }
}