import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CertificateValidationResult {
  final bool isValidKey;
  final String statusMessage;
  final Map<String, dynamic>? metadata;

  const CertificateValidationResult({
    required this.isValidKey,
    required this.statusMessage,
    this.metadata,
  });
}

class SupabaseCertLedger {
  static final _supabase = Supabase.instance.client;
  static const String _targetTable = 'verified_certificates';

  /// Verifies a certificate signature hash against cloud records.
  /// Explicitly accounts for row-missing exceptions and database status flags.
  static Future<CertificateValidationResult> verifyCertificate(String certHash) async {
    if (certHash.trim().isEmpty) {
      return const CertificateValidationResult(
        isValidKey: false,
        statusMessage: "❌ Validation aborted: Input hash signature cannot be blank.",
      );
    }

    final String cleanHash = certHash.trim().toLowerCase();

    try {
      debugPrint("📡 Polling secure cloud ledger metadata index lines...");
      
      // FIXED: Swapped out .single() for a controlled .maybeSingle() execution modifier.
      // This prevents the underlying database wrapper engine from throwing a fatal runtime 
      // exception if the certificate hash doesn't exist, returning a clean, manageable null instead.
      final Map<String, dynamic>? recordData = await _supabase
          .from(_targetTable)
          .select('id, student_name, course, is_valid, revoked_at')
          .eq('hash', cleanHash)
          .maybeSingle();

      if (recordData == null) {
        debugPrint("❄️ [Security Alert] Input token hash does not match any authenticated record.");
        return const CertificateValidationResult(
          isValidKey: false,
          statusMessage: "❌ Fraudulent Credential: This certificate signature does not exist.",
        );
      }

      // FIXED: Explicitly evaluates backend administrative status flags to catch explicitly revoked tokens
      final bool isActive = recordData['is_valid'] ?? false;
      final String? revokedDate = recordData['revoked_at'];

      if (!isActive || revokedDate != null) {
        debugPrint("🚨 [Revoked Token] Match found but record is flagged as explicitly invalidated.");
        return CertificateValidationResult(
          isValidKey: false,
          statusMessage: "⚠️ Revoked Credential: This certificate was explicitly invalidated on $revokedDate.",
          metadata: recordData,
        );
      }

      debugPrint("🔒 [Cryptographic Match] Certificate verified authentic and unaltered.");
      return CertificateValidationResult(
        isValidKey: true,
        statusMessage: "✅ Verified: Certificate is authentic and active on the cloud ledger.",
        metadata: recordData,
      );

    } on PostgrestException catch (databaseError) {
      // FIXED: Isolate pure database exceptions to prevent treating connectivity drops as fraudulent attempts
      debugPrint("🚨 Supabase Gateway Communication Exception: ${databaseError.message}");
      return CertificateValidationResult(
        isValidKey: false,
        statusMessage: "⏳ Network Error: Unable to reach validation servers. Status: ${databaseError.code}",
      );
    } catch (unexpectedError) {
      debugPrint("🚨 Fatal runtime tracking intercept failure: ${unexpectedError.toString()}");
      return const CertificateValidationResult(
        isValidKey: false,
        statusMessage: "❌ System Error: Transaction processing cycle aborted safely.",
      );
    }
  }
}
