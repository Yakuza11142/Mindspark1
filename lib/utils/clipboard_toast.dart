import 'package:flutter/material.dart';
import 'package:sks_ticket_view/sks_ticket_view.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/spark_transaction.dart';
import '../utils/clipboard_toast.dart'; // Make sure this path matches your file structure

class PremiumReceiptView extends StatelessWidget {
  final SparkTransaction tx;

  const PremiumReceiptView({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: SKSTicketView(
        backgroundColor: Colors.white, 
        contentPadding: const EdgeInsets.all(24),
        drawDivider: true,
        borderRadius: 12,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.verified, color: Colors.blue, size: 30),
            const SizedBox(height: 4),
            const Text(
              "OFFICIAL SPARK RECEIPT",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
                letterSpacing: 1.2,
                color: Color(0xFF0A0E21),
              ),
            ),
            const SizedBox(height: 15),

            Text(
              "${tx.amount}⚡",
              style: const TextStyle(
                fontSize: 48, 
                fontWeight: FontWeight.w900,
                color: Color(0xFF0A0E21),
              ),
            ),

            const Divider(height: 40, thickness: 1),

            // Context passed down to handle the copy action safely
            _buildRow(context, "From", tx.sender), 
            _buildRow(context, "To", tx.receiver),
            _buildRow(context, "Date", tx.formattedDate),
            _buildRow(context, "Auth Sig", tx.signature.toUpperCase()),

            const SizedBox(height: 30),

            QrImageView(
              data: "VERIFY:${tx.id}:${tx.sender}:${tx.signature}",
              version: QrVersions.auto,
              size: 150,
              eyeStyle: const QrEyeStyle(
                eyeShape: QrEyeShape.circle, 
                color: Color(0xFF0A0E21),
              ),
            ),

            const SizedBox(height: 10),
            const Text(
              "SECURE BLOCKCHAIN-HASHED QR",
              style: TextStyle(fontSize: 8, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, String value) {
    return GestureDetector(
      onTap: () => ClipboardToast.copy(context, value), // Tapping copies the raw data
      behavior: HitTestBehavior.opaque, // Makes the entire row space clickable
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6), // Increased slightly for better mobile thumb-targeting
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
            ),
            const SizedBox(width: 16), 
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.end,
                maxLines: 1,
                overflow: TextOverflow.ellipsis, 
                style: const TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 11,
                  color: Color(0xFF0A0E21),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
