import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCertLedger {
  static final _supabase = Supabase.instance.client;

  static Future<bool> verifyCertificate(String certHash) async {
    try {
      final data = await _supabase
          .from('verified_certificates')
          .select()
          .eq('hash', certHash)
          .single();
      return data != null; // Returns true if certificate is real
    } catch (e) {
      return false; // Hacker or fake cert
    }
  }
}