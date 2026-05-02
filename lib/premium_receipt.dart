import 'package:flutter/material.dart';
import 'package:sks_ticket_view/sks_ticket_view.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';

class SparkReceiptView extends StatelessWidget {
  final Map<String, dynamic> transactionData;

  const SparkReceiptView({super.key, required this.transactionData});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SKSTicketView(
        backgroundColor: const Color(0xFF1A237E), // Professional Indigo
        contentPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 0),
        drawDivider: true,
        borderRadius: 16,
        child: Container(
          width: 320,
          color: Colors.white,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Security Header
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.bolt, color: Colors.amber, size: 28),
                  Text("MINDSPARK SECURE", style: TextStyle(letterSpacing: 2, fontSize: 10, fontWeight: FontWeight.bold)),
                  Icon(Icons.verified_user, color: Colors.blue, size: 20),
                ],
              ),
              const SizedBox(height: 20),
              
              // Core Transaction Info
              Text("${transactionData['amount']} Sparks", style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w900)),
              const Text("TRANSFER VERIFIED", style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
              
              const SizedBox(height: 30), // Professional Divider Cut

              // Metadata Table
              _buildRow("Recipient ID", transactionData['receiver']),
              _buildRow("Network Node", "MS-NODE-04"),
              _buildRow("Auth Token", "#${transactionData['id'].toString().substring(0,8).toUpperCase()}"),
              _buildRow("Time", DateFormat('HH:mm:ss | dd MMM').format(DateTime.now())),
              
              const SizedBox(height: 25),

              // The Authentication QR
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade100),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: QrImageView(
                  data: "MS_AUTH:${transactionData['id']}",
                  version: QrVersions.auto,
                  size: 140,
                  eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.circle, color: Color(0xFF1A237E)),
                ),
              ),
              const SizedBox(height: 10),
              const Text("SCAN TO VALIDATE ON ANOTHER DEVICE", style: TextStyle(fontSize: 8, color: Colors.grey, letterSpacing: 0.5)),
            ],
          ),
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
          Text(label, style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
        ],
      ),
    );
  }
}
