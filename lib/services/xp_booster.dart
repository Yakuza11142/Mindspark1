import 'dart:async';

class XpBooster {
  bool active = false;
  void activate() {
    active = true;
    Timer(const Duration(minutes: 15), () => active = false);
  }
  int calculate(int base) => active ? base * 2 : base;
}