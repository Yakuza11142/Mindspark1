import 'dart:convert';
import 'package:crypto/crypto.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

class SecureCertLedger {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Pull a strong signing key from compile-time secrets.json matrix.
  static const String _secretSignatureKey = String.fromEnvironment('CERT_SIGNING_KEY');

  /// Mints a cryptographically signed certificate validation record to the cloud. [INDEX]
  static Future<String?> mintCertificate({
    required String studentName,
    required String course,
    required int score,
    required String userId,
  }) async {
    if (studentName.trim().isEmpty || course.trim().isEmpty || _secretSignatureKey.isEmpty) {
      developer.log("🚨 SecureCertLedger: Minting Aborted. Invalid parameters or unconfigured signing key.");
      return null;
    }

    try {
      // NOTE: For absolute financial/legal provenance integrity, compute this timestamp strictly on a backend server loop.
      final String issueDateIso = DateTime.now().toUtc().toIso8601String();
      final String cleanName = studentName.trim();
      final String cleanCourse = course.trim();

      // Build a Cryptographic Provenance Fingerprint tightly binding fields [INDEX]
      final String payloadToSign = '$userId|$cleanName|$cleanCourse|$score|$issueDateIso';

      final hmacSha256 = Hmac(sha256, utf8.encode(_secretSignatureKey));
      final Digest cryptographicSignature = hmacSha256.convert(utf8.encode(payloadToSign));
      final String secureTokenString = cryptographicSignature.toString();

      final Map<String, dynamic> certRecord = {
        'user_id': userId,
        'student_name': cleanName,
        'course': cleanCourse,
        'score': score,
        'issue_date': issueDateIso,
        'cryptographic_signature': secureTokenString,
        'is_valid': true
      };

      // Use the cryptographic token as the actual Document ID [INDEX]
      await _db.collection('verified_certificates').doc(secureTokenString).set(certRecord);

      return secureTokenString;
    } catch (e, stackTrace) {
      developer.log("❌ SecureCertLedger: Failed to sign and mint certificate", error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// Verifies a certificate signature and validates its data fields against alteration vectors. [INDEX]
  static Future<Map<String, dynamic>?> verifyCertificate(String verificationToken) async {
    final String cleanToken = verificationToken.trim();
    if (cleanToken.isEmpty || _secretSignatureKey.isEmpty) return null;

    try {
      final DocumentSnapshot<Map<String, dynamic>> doc = await _db
          .collection('verified_certificates')
          .doc(cleanToken)
          .get()
          .timeout(const Duration(seconds: 6)); // Timeout protects thread lifecycles from slow boots

      if (!doc.exists) {
        developer.log("❄️ SecureCertLedger: [Verification Failed] Token signature does not match any entry.");
        return null; 
      }

      // FIXED: Safely verify type mappings and extract raw payload documents without triggering casting crashes [INDEX]
      final Map<String, dynamic>? rawData = doc.data();
      if (rawData == null) {
        developer.log("⚠️ SecureCertLedger: Stored certificate object document returns completely null.");
        return null;
      }

      final Map<String, dynamic> data = Map<String, dynamic>.from(rawData);
      final bool isValid = data['is_valid'] ?? false;

      if (!isValid) {
        developer.log("🚨 SecureCertLedger: [Revoked Certificate] Token matches an explicitly blacklisted record.");
        return null;
      }

      // Perform secondary cryptographic integrity validation checks [INDEX]
      final String userId = data['user_id']?.toString() ?? '';
      final String name = data['student_name']?.toString() ?? '';
      final String course = data['course']?.toString() ?? '';
      final int score = int.tryParse(data['score'].toString()) ?? 0;
      final String date = data['issue_date']?.toString() ?? '';

      final String reconstructPayload = '$userId|$name|$course|$score|$date';
      final hmacSha256 = Hmac(sha256, utf8.encode(_secretSignatureKey));
      final String validationCheck = hmacSha256.convert(utf8.encode(reconstructPayload)).toString();

      if (validationCheck != cleanToken) {
        developer.log("🚨 SecureCertLedger: Database tampering detected! Certificate fields do not match signature.");
        return null; 
      }

      developer.log("🔒 SecureCertLedger: [Cryptographic Hit] Certificate verified authentic and unaltered.");
      return data;

    } catch (e, stackTrace) {
      developer.log("❌ SecureCertLedger: Verification sub-routine execution error", error: e, stackTrace: stackTrace);
      return null;
    }
  }
}
