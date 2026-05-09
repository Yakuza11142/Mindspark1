import 'package:flutter/services.dart';
class HapticsService {
  static void light() => HapticFeedback.lightImpact();
  static void medium() => HapticFeedback.mediumImpact();
}