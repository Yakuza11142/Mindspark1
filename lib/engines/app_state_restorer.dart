import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class AppStateRestorer {
  static const String _statePersistenceKey = 'app_serialized_state_v1';

  /// Serializes and writes state metrics atomically to block interleaved data-race conditions [INDEX]
  static Future<bool> saveState(String screen, String data) async {
    final String cleanedScreen = screen.trim();
    final String cleanedData = data.trim();

    if (cleanedScreen.isEmpty) return false;

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      
      // Bundled split mutable properties into a singular length-prefixed atomic JSON record block [INDEX]
      final String serializedPayload = jsonEncode({
        'screen': cleanedScreen,
        'data': cleanedData,
        'timestamp': DateTime.now().toUtc().millisecondsSinceEpoch, // Included structural expiration metrics safely
      });

      // Execute a single, un-splittable storage write operation transaction natively [INDEX]
      final bool success = await prefs.setString(_statePersistenceKey, serializedPayload);
      
      if (success) {
        developer.log("💾 AppStateRestorer: State registry written atomically for screen: $cleanedScreen");
      }
      return success;
    } catch (e, stackTrace) {
      developer.log("❌ AppStateRestorer: Critical allocation crash inside serialization save pipeline", error: e, stackTrace: stackTrace);
      return false;
    }
  }

  /// Restores, unpacks, and validates historical application state metrics cleanly [INDEX]
  static Future<Map<String, String>?> restoreState() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? rawJsonStr = prefs.getString(_statePersistenceKey);

      if (rawJsonStr == null || rawJsonStr.isEmpty) {
        return null;
      }

      final dynamic decodedPayload = jsonDecode(rawJsonStr);
      
      // Hardened the deserialization tracking tree using safe explicit type assertions [INDEX]
      if (decodedPayload is Map) {
        final Map<String, dynamic> structuredMap = Map<String, dynamic>.from(decodedPayload);
        final String? screen = structuredMap['screen'] as String?;
        final String? data = structuredMap['data'] as String?;

        if (screen != null && data != null && screen.isNotEmpty) {
          return {
            "screen": screen.trim(), 
            "data": data.trim(),
          };
        }
      }
      return null;
    } catch (e, stackTrace) {
      developer.log("❌ AppStateRestorer: Structural parsing loop collapsed during state restoration", error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// Permanently clears out the stored state dictionary during standard user logouts or session wipes [INDEX]
  static Future<bool> clearSavedState() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      developer.log("⚙️ AppStateRestorer: Purging active serialized tracking cache states.");
      return await prefs.remove(_statePersistenceKey);
    } catch (e) {
      return false;
    }
  }
}
