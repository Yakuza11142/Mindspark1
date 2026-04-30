import 'dart:math';
import 'package:vector_math/vector_math_64.dart';

class IKSolver {
  // Solves for the elbow/knee angle
  static double solve(double upperLen, double lowerLen, double targetDist) {
    double cosAngle = (pow(upperLen, 2) + pow(lowerLen, 2) - pow(targetDist, 2)) / 
                      (2 * upperLen * lowerLen);
    return acos(cosAngle.clamp(-1.0, 1.0));
  }
}
