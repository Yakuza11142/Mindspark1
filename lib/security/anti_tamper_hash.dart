import 'dart:io';
import 'package:crypto/crypto.dart';

class AntiTamperHash {
  static Future<bool> verifyFileIntegrity(File file, String expectedSha256) async {
    final stream = file.openRead();
    final hash = await sha256.bind(stream).first;
    return hash.toString() == expectedSha256;
  }
}