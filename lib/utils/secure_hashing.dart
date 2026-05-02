import 'dart:convert';
import 'package:crypto/crypto.dart';

class SecureHashing {
  static String hashData(String input) {
    var bytes = utf8.encode(input);
    return sha256.convert(bytes).toString();
  }
}