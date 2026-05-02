import 'package:flutter/material.dart';
import 'package:sks_ticket_view/sks_ticket_view.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/spark_transaction.dart';

class PremiumReceiptView extends StatelessWidget {
  final SparkTransaction tx;

  const PremiumReceiptView({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    return SKSTicketView(
      backgroundColor: const Color(0xFF0A0E21),
      contentPadding: const EdgeInsets.symmetric(vertical: 20),
      drawDivider: true,
      borderRadius: 12,
      child: Container(
        width: 320,
        color: Colors.white,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.verified, color: Colors.blue, size: 30),
            const Text("OFFICIAL SPARK RECEIPT", 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 1.2)),
            const SizedBox(height: 15),
            
            Text("${tx.amount}⚡", 
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w900)),
            
            const Divider(height: 40, thickness: 1),

            _buildRow("From", tx.sender),      // Display Sender
            _buildRow("To", tx.receiver),
            _buildRow("Date", tx.formattedDate),
            _buildRow("Auth Sig", tx.signature.toUpperCase()),
            
            const SizedBox(height: 30),

            QrImageView(
              // QR now includes sender info for verification
              data: "VERIFY:${tx.id}:${tx.sender}:${tx.signature}", 
              version: QrVersions.auto,
              size: 150,
              eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.circle, color: Color(0xFF0A0E21)),
            ),
            
            const SizedBox(height: 10),
            const Text("SECURE BLOCKCHAIN-HASHED QR", 
              style: TextStyle(fontSize: 8, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
        ],
      ),
    );
  }
}
