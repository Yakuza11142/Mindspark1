import 'dart:convert';
import 'package:crypto/crypto.dart';

class PeerVerificationCrypto {
  static bool verifyIncomingData(String payload, String providedHash) {
    var bytes = utf8.encode(payload + "MINDSPARK_P2P_SECRET");
    var digest = sha256.convert(bytes);
    return digest.toString() == providedHash;
  }
}