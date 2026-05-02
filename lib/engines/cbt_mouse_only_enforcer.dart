import 'package:flutter/services.dart';

class CbtMouseOnlyEnforcer {
  static void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    print("Keyboard disabled. User must tap on-screen options.");
  }
}