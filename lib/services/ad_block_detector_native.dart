import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<bool> checkAdBlockActive() async {
  // 1. Defend against network offline false-positives
  try {
    final connectivityCheck = await InternetAddress.lookup('one.one.one.one');
    if (connectivityCheck.isEmpty) return false; // Device is offline, not blocking
  } catch (_) {
    return false; // Confirmed network disconnection
  }

  // 2. Dual-Verification Pipeline: DNS Lookup + HTTP Resource Fetch
  try {
    const targetDomain = 'googleadservices.com';
    
    // Check 1: DNS Resolution
    final dnsResult = await InternetAddress.lookup(targetDomain);
    if (dnsResult.isEmpty) return true;

    // Check 2: Actual HTTP request (Catches local traffic interceptors)
    final response = await http.get(Uri.https(targetDomain)).timeout(
      const Duration(seconds: 3),
    );
    
    // Ad blockers often return a 403 Forbidden, 0, or block the connection entirely
    return response.statusCode == 0;
  } catch (_) {
    return true; // Connection was actively dropped or refused by local host rules
  }
}
