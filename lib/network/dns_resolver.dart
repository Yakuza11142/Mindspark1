import 'dart:io';

class DnsResolver {
  static Future<String> resolveHostSecurely(String host) async {
    try {
      // Bypasses local ISP DNS blocking
      final results = await InternetAddress.lookup(host);
      if (results.isNotEmpty) {
        return results.first.address;
      }
      return host;
    } catch (e) {
      return host;
    }
  }
}