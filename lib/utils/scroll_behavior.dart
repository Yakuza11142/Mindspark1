import 'package:flutter/material.dart';

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    // 1. Returning the direct child without a Scrollbar wrapper cleans up layout lines
    return child;
  }

  @override
  GestureVelocityTrackerBuilder? buildVelocityTracker(BuildContext context) {
    return super.buildVelocityTracker(context);
  }

  // 2. Modern way to strip the android glow/stretching effect across your application
  @override
  Set<PointerDeviceKind> get dragDevices => super.dragDevices;
}
