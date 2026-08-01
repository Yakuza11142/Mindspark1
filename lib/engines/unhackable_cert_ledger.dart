import 'dart:convert';
import 'package:crypto/crypto.dart'; // From your pubspec.yaml
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class SecureCertLedger {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // FIXED: Pull a strong signing key from compile-time secrets.json matrix.
  // This key must NEVER be leaked or exposed to the client interface layout.
  static const String _secretSignatureKey = String.fromEnvironment('CERT_SIGNING_KEY');

  /// Mints a cryptographically signed certificate validation record to the cloud.
  static Future<String?> mintCertificate({
    required String studentName,
    required String course,
    required int score,
    required String userId,
  }) async {
    // FIXED: Swapped silent error prints for controlled parameter guards
    if (studentName.trim().isEmpty || course.trim().isEmpty || _secretSignatureKey.isEmpty) {
      debugPrint("🚨 Minting Aborted: Invalid data parameters or missing secure signature key configuration.");
      return null;
    }

    try {
      final String issueDateIso = DateTime.now().toUtc().toIso8601String();
      final String cleanName = studentName.trim();
      final String cleanCourse = course.trim();

      // FIXED: Build a Cryptographic Provenance Fingerprint.
      // Binds the student's data fields tightly to a single validation block string.
      final String payloadToSign = '$userId|$cleanName|$cleanCourse|$score|$issueDateIso';
      
      final hmacSha256 = Hmac(sha256, utf8.encode(_secretSignatureKey));
      final Digest cryptographicSignature = hmacSha256.convert(utf8.encode(payloadToSign));
      final String secureTokenString = cryptographicSignature.toString();

      // Store the tracking parameters cleanly in your cloud collection
      final Map<String, dynamic> certRecord = {
        'user_id': userId,
        'student_name': cleanName,
        'course': cleanCourse,
        'score': score,
        'issue_date': issueDateIso,
        'cryptographic_signature': secureTokenString,
        'is_valid': true
      };

      // FIXED: Use the cryptographic token as the actual Document ID.
      // This eliminates brute-force ID guessing entirely, as tokens are mathematically unguessable SHA-256 strings.
      await _db.collection('verified_certificates').doc(secureTokenString).set(certRecord);

      return secureTokenString;
    } catch (e) {
      debugPrint("❌ Failed to cryptographically sign and mint certificate: ${e.toString()}");
      return null;
    }
  }

  /// Verifies a certificate signature and validates its data fields against alteration vectors.
  static Future<Map<String, dynamic>?> verifyCertificate(String verificationToken) async {
    if (verificationToken.trim().isEmpty || _secretSignatureKey.isEmpty) return null;

    try {
      final DocumentSnapshot doc = await _db
          .collection('verified_certificates')
          .doc(verificationToken.trim())
          .get();

      if (!doc.exists) {
        debugPrint("❄️ [Verification Failed] Token signature does not match any entry in cloud records.");
        return null; // FRAUDULENT ENTRY
      }

      final Map<String, dynamic> data = Map<String, dynamic>.from(doc.data() as Map);
      final bool isValid = data['is_valid'] ?? false;
      
      if (!isValid) {
        debugPrint("🚨 [Revoked Certificate] Token matches an explicitly blacklisted record.");
        return null;
      }

      // FIXED: Perform a secondary integrity crosscheck.
      // Regenerate the hash signature locally using the stored fields to verify that 
      // nobody has manually altered the score or name fields inside the database console.
      final String userId = data['user_id'] ?? '';
      final String name = data['student_name'] ?? '';
      final String course = data['course'] ?? '';
      final int score = data['score'] ?? 0;
      final String date = data['issue_date'] ?? '';

      final String reconstructPayload = '$userId|$name|$course|$score|$date';
      final hmacSha256 = Hmac(sha256, utf8.encode(_secretSignatureKey));
      final String validationCheck = hmacSha256.convert(utf8.encode(reconstructPayload)).toString();

      if (validationCheck != verificationToken.trim()) {
        debugPrint("🚨 SECURITY ALERT: Database tampering detected! Certificate data fields do not match signature hash.");
        return null; // FRAUD DETECTED (Data was manipulated behind the scenes)
      }

      debugPrint("🔒 [Cryptographic Hit] Certificate verified authentic and unaltered.");
      return data;

    } catch (e) {
      debugPrint("🚨 Verification sub-routine execution error: ${e.toString()}");
      return null;
    }
  }
}
