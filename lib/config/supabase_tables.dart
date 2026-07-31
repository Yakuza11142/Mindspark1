import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseTables {
  static const String profiles = 'profiles';
  static const String examHistory = 'exam_history';
  static const String verifiedCerts = 'verified_certificates';
  
  // NOTE: Consider migrating this entirely to a Firebase Crashlytics or Sentry integration 
  // to avoid hitting database transaction performance caps during high-traffic intervals.
  static const String crashLogs = 'crash_logs';

  /// ⚙️ PRODUCTION HELPER: Write explicit, self-documenting queries branchlessly
  /// Example: SupabaseTables.selectFrom(SupabaseTables.profiles)...
  static PostgrestFilterBuilder<List<Map<String, dynamic>>> selectFrom(String tableName) {
    // Automatically wraps your central constants inside standard data capture hooks
    return Supabase.instance.client.from(tableName).select();
  }
}

/// 🛡️ SCHEMATIC FIELDS MATRIX: Prevents typos across your deep query filters
class ProfileFields {
  static const String id = 'id';
  static const String updatedAt = 'updated_at';
  static const String username = 'username';
  static const String fullHologramData = 'hologram_vector_payload';
}

class ExamFields {
  static const String id = 'id';
  static const String studentId = 'student_id';
  static const String testScore = 'score_metric';
  static const String isVerified = 'is_verified';
}
