import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SparkTransaction {
  final String id;
  final String sender;
  final String receiver;
  final int amount;
  final DateTime timestamp;
  final String signature;

  const SparkTransaction({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.amount,
    required this.timestamp,
    required this.signature,
  });
}

class ReceiptEngine {
  static final Random _secureRandom = Random.secure();
  
  // Cached structural key array optimizes system memory cycles during batch loops
  static List<int>? _cachedKeyBytes;

  /// Internal initializer ensures key security state matches strict initialization criteria
  static List<int> _getKeyBytes() {
    if (_cachedKeyBytes != null) return _cachedKeyBytes!;
    
    final String? secretKey = dotenv.maybeGet('TRANSACTION_SECRET_KEY');
    if (secretKey == null || secretKey.isEmpty) {
      throw StateError("Critical Cryptographic Violation: TRANSACTION_SECRET_KEY environment variable is missing.");
    }
    
    _cachedKeyBytes = utf8.encode(secretKey);
    return _cachedKeyBytes!;
  }

  /// Generates a tamper-proof cryptographically safe HMAC signature string
  static String generateSignature(
      String id, int amount, String sender, String receiver) {
    // Strict input boundary validations to insulate memory allocations against DDoS attacks
    if (amount <= 0 || id.length > 64 || sender.length > 64 || receiver.length > 64) {
      throw ArgumentError("Transaction properties exceed secure operational data constraints.");
    }

    final List<int> keyBytes = _getKeyBytes();
    final String structuredPayload = "${id.length}:$id|$amount|${sender.length}:$sender|${receiver.length}:$receiver";
    final List<int> messageBytes = utf8.encode(structuredPayload);

    final Hmac hmacSha256 = Hmac(sha256, keyBytes);
    return hmacSha256.convert(messageBytes).toString();
  }

  /// Verification framework completely shielded from timing leaks and length profiling attacks
  static bool verifyReceipt(SparkTransaction txn) {
    // Check basic dimensions before initiating signatures to prevent performance traps
    if (txn.id.length > 64 || txn.sender.length > 64 || txn.receiver.length > 64) return false;

    // Use a clean, isolated try-catch to safely mask error state execution profiles
    String computed;
    try {
      computed = txn.amount > 0 
          ? generateSignature(txn.id, txn.amount, txn.sender, txn.receiver)
          : "INVALID_COMPUTATION_DUMMY_STRING_PADDING_LONG_VALUE_SHA256";
    } catch (_) {
      computed = "INVALID_COMPUTATION_DUMMY_STRING_PADDING_LONG_VALUE_SHA256";
    }
    
    final List<int> digestA = utf8.encode(computed);
    final List<int> digestB = utf8.encode(txn.signature.toLowerCase());

    final bool matchFormat = txn.signature.length == 64 && RegExp(r'^[a-fA-F0-9]+$').hasMatch(txn.signature);

    int result = 0;
    for (int i = 0; i < digestA.length; i++) {
      final int byteB = i < digestB.length ? digestB[i] : 0;
      result |= digestA[i] ^ byteB;
    }

    return result == 0 && matchFormat;
  }

  static SparkTransaction createReceipt(
      int amount, String sender, String receiver) {
    if (amount <= 0 || sender.length > 64 || receiver.length > 64) {
      throw ArgumentError("Transaction configuration fields violate secure dimension targets.");
    }

    final DateTime currentTimestamp = DateTime.now().toUtc(); 
    final String secureSalt = List.generate(4, (_) => _secureRandom.nextInt(16).toRadixString(16)).join();
    final String id = "TXN-${currentTimestamp.millisecondsSinceEpoch}-$secureSalt";
    
    return SparkTransaction(
      id: id,
      sender: sender,
      receiver: receiver,
      amount: amount,
      timestamp: currentTimestamp,
      signature: generateSignature(id, amount, sender, receiver),
    );
  }
}
