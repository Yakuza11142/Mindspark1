import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:developer' as developer;

class UnfailingPaymentQueue {
  // Centralized key registries ensuring zero raw-string duplication across loops
  static const String _storageKeyQueue = "pending_secure_transactions";
  static const String _tablePayments = 'payments';
  
  static final SupabaseClient _supabase = Supabase.instance.client;
  static bool _isSyncingActive = false; // Mutex lock preventing concurrent background loop overlaps

  /// Saves transaction receipt profiles locally to disk partition cache memory
  static Future<void> logPaymentLocally({
    required String transactionId, 
    required double amount,
  }) async {
    final String sanitizedId = transactionId.trim();
    if (sanitizedId.isEmpty || amount <= 0.0) return;

    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      final List<String> temporaryQueue = preferences.getStringList(_storageKeyQueue) ?? [];

      final Map<String, dynamic> rawReceiptMap = {
        'transaction_id': sanitizedId,
        'amount': amount,
        'timestamp': DateTime.now().toIso8601String(),
        'status': 'pending_sync'
      };

      // Add encoded item down into storage queue array tracks
      temporaryQueue.add(jsonEncode(rawReceiptMap));
      await preferences.setStringList(_storageKeyQueue, temporaryQueue);

      developer.log("💳 Payment Vault: Local receipt secured for transaction identity: $sanitizedId");

      // Auto-trigger immediate non-blocking sync evaluation pass
      syncPaymentsWithServer();
    } catch (storageError) {
      developer.log("🚨 Payment Vault Error: Failed committing local transaction cache write.");
    }
  }

  /// Processes queued payment buffers sequentially over open backend server channels
  static Future<void> syncPaymentsWithServer() async {
    // Structural Guard: Block simultaneous concurrent execution passes to prevent data racing
    if (_isSyncingActive) return;
    _isSyncingActive = true;

    try {
      // FIX: Corrected API signature validation to support connectivity_plus array results
      final List<ConnectivityResult> networkStatusList = await Connectivity().checkConnectivity();
      
      if (networkStatusList.contains(ConnectivityResult.none)) {
        developer.log("📡 Payment Vault: Client device is currently offline. Sync pass paused.");
        _isSyncingActive = false;
        return;
      }

      final SharedPreferences preferences = await SharedPreferences.getInstance();
      final List<String> currentQueue = preferences.getStringList(_storageKeyQueue) ?? [];

      if (currentQueue.isEmpty) {
        _isSyncingActive = false;
        return;
      }

      developer.log("🌍 Payment Vault: Open connection verified. Processing ${currentQueue.length} outstanding tasks.");

      // Allocate dedicated index tracking arrays to safely segment completed actions
      final List<String> successfullySyncedItems = [];

      for (final String serializedReceipt in currentQueue) {
        try {
          final Map<String, dynamic> receiptMap = jsonDecode(serializedReceipt);
          
          final bool uploadVerification = await _sendToSupabase(receiptMap);
          if (uploadVerification) {
            successfullySyncedItems.add(serializedReceipt);
          }
        } catch (jsonDecodeError) {
          // Flag corrupted JSON entries for drop-out cleanup loops
          successfullySyncedItems.add(serializedReceipt);
        }
      }

      // Re-read storage fresh before updating to prevent multi-screen state collisions
      final List<String> accurateFreshQueue = preferences.getStringList(_storageKeyQueue) ?? [];
      
      // FIX: Safely remove elements without corrupting running array iteration pipelines
      accurateFreshQueue.removeWhere((queueItem) => successfullySyncedItems.contains(queueItem));
      await preferences.setStringList(_storageKeyQueue, accurateFreshQueue);
      
      developer.log("🎯 Payment Vault: Sync processing pass complete. Outstanding queue size: ${accurateFreshQueue.length}");
    } catch (globalSyncException) {
      developer.log("🚨 Payment Vault Failure: General synchronization exception encountered: $globalSyncException");
    } finally {
      _isSyncingActive = false; // Release execution lock
    }
  }

  /// Commits standard upsert calls to verify endpoint storage rows without duplicate creation risks
  static Future<bool> _sendToSupabase(Map<String, dynamic> receipt) async {
    try {
      await _supabase.from(_tablePayments).upsert({
        'id': receipt['transaction_id'], 
        'amount': receipt['amount'],
        'created_at': receipt['timestamp'],
        'sync_status': 'synced',
      });
      return true;
    } catch (supabaseNetworkError) {
      developer.log("❌ Payment Vault: Database upload target rejected request: $supabaseNetworkError");
      return false;
    }
  }
}
