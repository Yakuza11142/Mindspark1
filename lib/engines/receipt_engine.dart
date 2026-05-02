import 'dart:convert';
import 'package:crypto/crypto.dart';

class ReceiptEngine {
  /// signature now includes the sender to prevent forgery
  static String generateSignature(String id, int amount, String sender, String receiver) {
    var bytes = utf8.encode("$id$amount$sender$receiver-SECRET_KEY_123"); 
    return sha256.convert(bytes).toString().substring(0, 10);
  }

  static SparkTransaction createReceipt(int amount, String sender, String receiver) {
    final id = "TXN-${DateTime.now().millisecondsSinceEpoch}";
    return SparkTransaction(
      id: id,
      sender: sender,
      receiver: receiver,
      amount: amount,
      timestamp: DateTime.now(),
      signature: generateSignature(id, amount, sender, receiver),
    );
  }
}
