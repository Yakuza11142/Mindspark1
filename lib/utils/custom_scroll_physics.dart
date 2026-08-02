import 'package:flutter/material.dart';

class BouncyScroll extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    // Forces the bouncing effect on top of any existing base physics configuration
    return const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
  }
}
