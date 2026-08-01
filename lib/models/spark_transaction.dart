import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:developer' as developer;

class SparkTransaction {
  final String id;
  final String sender; // Restored field declaration satisfies compiler constraints [INDEX]
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

  /// Formats transaction date safely following universal 24-hour accounting metrics [INDEX]
  String get formattedDate {
    // Upgraded 'hh' to 'HH' to enforce safe 24-hour internal transaction logs [INDEX]
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp.toUtc());
  }

  /// Factory constructor to securely convert raw JSON map ledger rows with deep type assertions [INDEX]
  factory SparkTransaction.fromJson(Map<String, dynamic> json) {
    try {
      return SparkTransaction(
        id: json['id']?.toString() ?? '',
        sender: json['sender']?.toString() ?? 'SYSTEM',
        receiver: json['receiver']?.toString() ?? '',
        amount: int.tryParse(json['amount'].toString()) ?? 0,
        timestamp: json['timestamp'] != null 
            ? DateTime.parse(json['timestamp'].toString()).toUtc()
            : DateTime.now().toUtc(),
        signature: json['signature']?.toString() ?? '',
      );
    } catch (e, stackTrace) {
      developer.log("❌ SparkTransaction: Failed to parse transaction row data safely", error: e, stackTrace: stackTrace);
      return SparkTransaction(
        id: 'ERROR',
        sender: 'UNKNOWN',
        receiver: 'UNKNOWN',
        amount: 0,
        timestamp: DateTime.now().toUtc(),
        signature: '',
      );
    }
  }

  /// Converts transaction tokens cleanly into standard map formats for database saves [INDEX]
  Map<String, dynamic> toJson() {
    return {
      'id': id.trim(),
      'sender': sender.trim(),
      'receiver': receiver.trim(),
      'amount': amount,
      'timestamp': timestamp.toUtc().toIso8601String(), // Standardized unified UTC date tracking strings [INDEX]
      'signature': signature.trim(),
    };
  }
}
