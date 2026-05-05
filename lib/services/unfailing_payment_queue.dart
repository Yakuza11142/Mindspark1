import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UnfailingPaymentQueue {
  static const String queueKey = "pending_secure_transactions";
  static final _supabase = Supabase.instance.client;

  // =========================================================================
  // 1. SAVE THE RECEIPT LOCALLY
  // =========================================================================
  static Future<void> logPaymentLocally(String transactionId, double amount) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> queue = prefs.getStringList(queueKey) ?? [];
    
    Map<String, dynamic> receipt = {
      'transaction_id': transactionId,
      'amount': amount,
      'timestamp': DateTime.now().toIso8601String(),
      'status': 'pending_sync'
    };
    
    queue.add(jsonEncode(receipt));
    await prefs.setStringList(queueKey, queue);
    
    print("💳 PAYMENT SECURED LOCALLY: Vaulted for Cloud Sync.");
    
    // Attempt immediate sync if internet exists
    syncPaymentsWithServer();
  }

  // =========================================================================
  // 2. THE BACKGROUND SYNC
  // =========================================================================
  static Future<void> syncPaymentsWithServer() async {
    // Check connectivity
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      print("📡 Offline. Receipts safely stored in phone vault.");
      return; 
    }

    final prefs = await SharedPreferences.getInstance();
    List<String> queue = prefs.getStringList(queueKey) ?? [];
    
    if (queue.isEmpty) return;

    print("🌍 Internet active. Syncing ${queue.length} payments to Supabase...");

    List<String> syncedIds = [];

    for (String item in queue) {
      final receipt = jsonDecode(item);
      
      bool success = await _sendToSupabase(receipt);
      if (success) {
        syncedIds.add(item); 
      }
    }

    // Clean up the local queue
    queue.removeWhere((item) => syncedIds.contains(item));
    await prefs.setStringList(queueKey, queue);
  }

  // =========================================================================
  // 3. SUPABASE UPLOAD (Upsert for safety)
  // =========================================================================
  static Future<bool> _sendToSupabase(Map<String, dynamic> receipt) async {
    try {
      // Use 'upsert' so if it retries, it won't create duplicate rows
      await _supabase.from('payments').upsert({
        'id': receipt['transaction_id'], // Primary Key in Supabase
        'amount': receipt['amount'],
        'created_at': receipt['timestamp'],
        'sync_status': 'synced',
      });
      return true; 
    } catch (e) {
      print("❌ Supabase Sync Failed: $e");
      return false; 
    }
  }
}
