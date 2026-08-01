import 'dart:convert';
import 'package:crypto/crypto.dart';

class PeerVerificationCrypto {
  // Extracted core signature constants to prevent string literal repetition
  static const String _p2pSaltSecret = "MINDSPARK_P2P_SECRET";

  /// Verifies incoming network strings securely using a constant-time execution check
  static bool verifyIncomingData(String payload, String providedHash) {
    // Generate the baseline hash profile using your established shared secret seed
    final List<int> computedBytes = utf8.encode("$payload$_p2pSaltSecret");
    final String generatedHashString = sha256.convert(computedBytes).toString();

    // Convert both hash profiles straight into mutable byte buffers for comparative parsing
    final List<int> generatedHashBytes = utf8.encode(generatedHashString);
    final List<int> providedHashBytes = utf8.encode(providedHash);

    // FIX: Check string metrics securely without exposing timing differences to attackers
    if (generatedHashBytes.length != providedHashBytes.length) {
      return false;
    }

    int comparisonResultAccumulator = 0;

    // Bitwise OR operations ensure the loop executes fully over the entire array width
    for (int i = 0; i < generatedHashBytes.length; i++) {
      comparisonResultAccumulator |= generatedHashBytes[i] ^ providedHashBytes[i];
    }

    // A result accumulator of exactly 0 confirms all bytes matched perfectly
    return comparisonResultAccumulator == 0;
  }
}
