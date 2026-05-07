import 'package:flutter/material.dart';

class DynamicExamSlipGenerator extends StatelessWidget {
  final String examName;
  final String studentName;
  
  // Global mapping of Official Titles
  static const Map<String, String> examTitles = {
    "SAT": "COLLEGE BOARD ADMISSION TICKET",
    "JAMB": "UTME OFFICIAL EXAMINATION SLIP",
    "WAEC": "WEST AFRICAN SENIOR SCHOOL CERTIFICATE SLIP",
    "NECO": "NATIONAL EXAMINATIONS COUNCIL TICKET",
  };

  const DynamicExamSlipGenerator({
    super.key, 
    required this.examName, 
    this.studentName = "CANDIDATE",
  });

  @override
  Widget build(BuildContext context) {
    // Falls back to a generic title if the exam isn't in the global map
    final String header = examTitles[examName] ?? "${examName.toUpperCase()} EXAMINATION SLIP";

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            header, 
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black, 
              fontWeight: FontWeight.bold, 
              fontSize: 16,
              letterSpacing: 1.1,
            ),
          ),
          const Divider(height: 30, thickness: 1.5, color: Colors.black),
          _buildRow("CANDIDATE NAME:", studentName.toUpperCase()),
          const SizedBox(height: 12),
          _buildRow("VERIFICATION:", "AUTHORIZED / ACTIVE", isStatus: true),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isStatus = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
        Text(
          value, 
          style: TextStyle(
            color: isStatus ? Colors.blue.shade900 : Colors.black, 
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
