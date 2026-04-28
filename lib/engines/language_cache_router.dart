import 'dart:convert';
import 'package:crypto/crypto.dart';

class LanguageCacheRouter {
  static String generateCacheHash(String topic, String language, String persona) {
    String raw = "$topic|$language|$persona";
    return sha256.convert(utf8.encode(raw)).toString();
  }
  // This hash is used to query Supabase to see if this exact video was already generated.
}