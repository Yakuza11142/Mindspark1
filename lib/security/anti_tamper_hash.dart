import 'dart:io';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:developer' as developer;

class AntiTamperHash {
  /// Verifies a file asset's checksum asynchronously using a secure, constant-time byte comparison.
  static Future<bool> verifyFileIntegrity(File file, String expectedSha256) async {
    // Basic structural length guard to catch malformed target parameters early
    final String sanitizedExpectedHash = expectedSha256.trim().toLowerCase();
    if (sanitizedExpectedHash.isEmpty) return false;

    try {
      // Stream file chunks safely into the cryptographic transformer engine
      final stream = file.openRead();
      final Digest computedDigest = await sha256.bind(stream).first;
      final String generatedHashString = computedDigest.toString().toLowerCase();

      // Convert hash strings directly into mutable byte arrays for constant-time evaluation
      final List<int> generatedBytes = utf8.encode(generatedHashString);
      final List<int> expectedBytes = utf8.encode(sanitizedExpectedHash);

      // Instantly drop verification if sizes do not align perfectly
      if (generatedBytes.length != expectedBytes.length) {
        return false;
      }

      int comparisonAccumulator = 0;

      // FIX: Bitwise XOR forces full-array validation execution to eliminate timing leaks
      for (int i = 0; i < generatedBytes.length; i++) {
        comparisonAccumulator |= generatedBytes[i] ^ expectedBytes[i];
      }

      // An accumulator total of exactly 0 confirms a perfect payload identity verification
      return comparisonAccumulator == 0;
    } on FileSystemException catch (fsError, stackTrace) {
      developer.log(
        "🚨 AntiTamper: Failed to read file data buffer from disk. Integrity check aborted.",
        error: fsError,
        stackTrace: stackTrace,
      );
      return false; // Fail-secure protection fallback strategy
    } catch (genericError) {
      return false;
    }
  }
}
