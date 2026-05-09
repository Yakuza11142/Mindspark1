import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

class QrEngine {
  // Generates a QR Code Widget for the PDF
  static Widget generateQr(String data) {
    return QrImageView(
      data: data,
      version: QrVersions.auto,
      size: 100.0,
    );
  }
  
  static String generateVerificationLink(String studentName, String course) {
    // In a real app, this links to your website.
    // For MVP, it links to a validation string.
    return "https://mindspark.app/verify?student=${Uri.encodeComponent(studentName)}&course=${Uri.encodeComponent(course)}";
  }
}