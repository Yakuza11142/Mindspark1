import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCore {
  // FIXED: ZERO HARDCODING. Pull tracking endpoints safely from compile-time environments
  static const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const String supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (_isInitialized) return;
    if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
      throw ArgumentError("❌ FATAL: Supabase environment credentials are unmapped.");
    }

    try {
      await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
      _isInitialized = true;
      
      // Ignite the background network reconciliation engine automatically at initialization boot
      unawaited(synchronizeOfflineQueue());
    } catch (e) {
      debugPrint("🚨 Supabase Core initialization failed: ${e.toString()}");
    }
  }

  /// Production-ready data insertion with automated offline fallback tracking
  static Future<void> securelySaveScore({
    required String userId,
    required int score,
    required String exam,
  }) async {
    final client = Supabase.instance.client;
    final String timestampIso = DateTime.now().toUtc().toIso8601String();

    try {
      debugPrint("📡 Uploading score metric dynamically to cloud database rows...");
      await client.from('exam_results').insert({
        'user_id': userId,
        'exam_type': exam.trim(),
        'score': score,
        'timestamp': timestampIso,
      });
      debugPrint("🎯 Exam score successfully backed up to cloud ledger.");
    } catch (networkError) {
      debugPrint("⚠️ Network offline block caught: ${networkError.toString()}. Queuing fallback locally...");
      
      try {
        final prefs = await SharedPreferences.getInstance();
        final List<String> offlineQueue = prefs.getStringList('offline_scores') ?? [];

        // FIXED: Swapped out risky manual string interpolation for robust standard jsonEncoding.
        // This safely escapes quotations, spaces, and commas inside custom text inputs automatically.
        final Map<String, dynamic> localCacheBlock = {
          'user_id': userId,
          'exam_type': exam.trim(),
          'score': score,
          'timestamp': timestampIso,
        };

        offlineQueue.add(jsonEncode(localCacheBlock));
        await prefs.setStringList('offline_scores', offlineQueue);
        debugPrint("🔒 Transaction logged securely inside device flash backup tables.");
      } catch (storageError) {
        debugPrint("🚨 Core storage fault: Unable to preserve metrics to flash disk: $storageError");
      }
    }
  }

  /// ⚙️ AUTOMATED BACKGROUND SYNC ENGINE: Reconciles local queues cleanly when networks stabilize
  static Future<void> synchronizeOfflineQueue() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> offlineQueue = prefs.getStringList('offline_scores') ?? [];

      if (offlineQueue.isEmpty) {
        debugPrint("📋 Offline transaction queue is currently empty. Sync loop completed.");
        return;
      }

      debugPrint("🛰️ Found ${offlineQueue.length} pending local records. Attempting cloud synchronization...");
      final client = Supabase.instance.client;
      final List<String> unexportedRecords = [];

      for (final String cachedJson in offlineQueue) {
        try {
          final Map<String, dynamic> dataMap = jsonDecode(cachedJson) as Map<String, dynamic>;

          // Attempt to upload individual items sequentially back into the live cloud table
          await client.from('exam_results').insert({
            'user_id': dataMap['user_id'],
            'exam_type': dataMap['exam_type'],
            'score': dataMap['score'],
            'timestamp': dataMap['timestamp'],
          });
        } catch (uploadError) {
          // If a record fails to sync (e.g. timeout remains), hold it in the recovery array to prevent data loss
          unexportedRecords.add(cachedJson);
          debugPrint("⏳ Record synchronization deferred safely: Connection un-stabilized.");
        }
      }

      // Overwrite the local preference file with only the remaining unexported rows
      await prefs.setStringList('offline_scores', unexportedRecords);
      debugPrint("🏁 Offline cache synchronization loop closed. Remaining unresolved elements: ${unexportedRecords.length}");

    } catch (e) {
      debugPrint("🚨 Error running automated network sync reconciliation task: ${e.toString()}");
    }
  }
}
