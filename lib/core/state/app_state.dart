import 'package:flutter/foundation.dart';

class AppState<T> extends ValueNotifier<T> {
  AppState(super.value);
  void update(T newValue) {
    value = newValue;
    notifyListeners();
  }
}
