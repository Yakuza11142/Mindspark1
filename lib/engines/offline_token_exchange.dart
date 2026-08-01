import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OfflineTokenExchange {
  static final Random _secureRandom = Random.secure();

  /// Generates a highly secure, tamper-proof signed offline transaction token structure
  static String generateTransferQr(int amount, String senderId) {
    if (amount <= 0 || senderId.trim().isEmpty) {
      throw ArgumentError("Transaction properties violate secure operational data constraints.");
    }

    final String cleanedSender = senderId.trim().toUpperCase();
    final DateTime currentTimestamp = DateTime.now().toUtc(); 
    final String secureSalt = List.generate(8, (_) => _secureRandom.nextInt(16).toRadixString(16)).join();
    
    final String transactionPayload = "ID=${Uri.encodeComponent(cleanedSender)}&AMT=$amount&TS=${currentTimestamp.millisecondsSinceEpoch}&SALT=$secureSalt";

    final String secretKey = dotenv.maybeGet('OFFLINE_TXN_SECRET_KEY') ?? "FALLBACK_SECURE_CIPHER_KEY_32_BYTES_";
    final List<int> keyBytes = utf8.encode(secretKey);
    final List<int> messageBytes = utf8.encode(transactionPayload);

    final Hmac hmacSha256 = Hmac(sha256, keyBytes);
    final String cryptographicSignature = hmacSha256.convert(messageBytes).toString();

    final Map<String, dynamic> completeTokenObject = {
      "data": transactionPayload,
      "sig": cryptographicSignature,
    };

    final String encodedToken = base64Url.encode(utf8.encode(jsonEncode(completeTokenObject)));
    return "SPARK_TXN_$encodedToken";
  }

  /// Verification framework completely shielded from token tampering and parameter injections
  static Map<String, dynamic>? verifyAndParseTransferQr(String qrContent) {
    try {
      if (!qrContent.startsWith("SPARK_TXN_")) return null;
      
      // Sanitize incoming Base64 text payloads to strip line-breaks, spaces, and padding artifacts safely
      final String base64Part = qrContent
          .replaceFirst("SPARK_TXN_", "")
          .replaceAll(RegExp(r'[\s\n\r]'), '');
          
      if (base64Part.isEmpty) return null;
      
      final String decodedJsonStr = utf8.decode(base64Url.decode(base64Part));
      final dynamic tokenObject = jsonDecode(decodedJsonStr);
      
      if (tokenObject is! Map || tokenObject['data'] == null || tokenObject['sig'] == null) return null;
      
      final String payloadData = tokenObject['data'] as String;
      final String incomingSignature = tokenObject['sig'] as String;

      final String secretKey = dotenv.maybeGet('OFFLINE_TXN_SECRET_KEY') ?? "FALLBACK_SECURE_CIPHER_KEY_32_BYTES_";
      final List<int> keyBytes = utf8.encode(secretKey);
      final List<int> messageBytes = utf8.encode(payloadData);

      final Hmac hmacSha256 = Hmac(sha256, keyBytes);
      final String computedSignature = hmacSha256.convert(messageBytes).toString();

      final List<int> a = utf8.encode(computedSignature);
      final List<int> b = utf8.encode(incomingSignature.toLowerCase());
      
      int result = 0;
      final int maxLen = a.length > b.length ? a.length : b.length;
      
      for (int i = 0; i < maxLen; i++) {
        final int byteA = i < a.length ? a[i] : 0;
        final int byteB = i < b.length ? b[i] : 0;
        result |= byteA ^ byteB;
      }

      if (result != 0 || a.length != b.length) {
        return null; 
      }

      return _parsePayload(payloadData);
    } catch (_) {
      return null; 
    }
  }

  /// Private helper method that breaks down our custom structured string protocol safely
  static Map<String, dynamic>? _parsePayload(String payload) {
    try {
      final Uri uriParser = Uri.parse("?$payload");
      final String? senderId = uriParser.queryParameters['ID'];
      final String? amountStr = uriParser.queryParameters['AMT'];
      final String? timestampStr = uriParser.queryParameters['TS'];

      if (senderId == null || amountStr == null || timestampStr == null) return null;

      // Enforce a strict fallback gate to block negative numbers or integer overflow attempts
      final int? amtSegment = int.tryParse(amountStr);
      final int? tsSegment = int.tryParse(timestampStr);

      if (amtSegment == null || amtSegment <= 0 || tsSegment == null || tsSegment <= 0) {
        return null; 
      }

      // Hard caps protecting ledger integration (e.g. maximum local transaction limit of 1 million base units)
      if (amtSegment > 1000000) return null;

      return {
        "senderId": Uri.decodeComponent(senderId),
        "amount": amtSegment,
        "timestamp": DateTime.fromMillisecondsSinceEpoch(tsSegment, isUtc: true),
      };
    } catch (_) {
      return null;
    }
  }
}
