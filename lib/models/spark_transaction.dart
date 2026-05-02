import 'package:intl/intl.dart';

class SparkTransaction {
  final String id;
  final String receiver;
  final int amount;
  final DateTime timestamp;
  final String signature; // Used for the "No-Forgery" check

  SparkTransaction({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.amount,
    required this.timestamp,
    required this.signature,
  });

  // Formats date safely without hardcoding strings
  String get formattedDate => DateFormat('dd MMM yyyy, hh:mm a').format(timestamp);
}
