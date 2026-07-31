import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WinBackDiscountEngine {
  /// Evaluates user absence metrics safely against temporal manipulation vectors.
  static Future<bool> shouldOffer50PercentDiscount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? lastLoginStr = prefs.getString('last_login_date');
      
      if (lastLoginStr == null) return false;

      final DateTime lastLogin = DateTime.parse(lastLoginStr).toUtc();
      
      // FIXED: Standardised calculation loops around Coordinated Universal Time (UTC) 
      // to render operations immune to local mobile device timezone changes.
      final DateTime currentDeviceTime = DateTime.now().toUtc();

      // FIXED: Added a structural guard to eliminate back-dating time adjustments.
      if (currentDeviceTime.isBefore(lastLogin)) {
        debugPrint("⚠️ Temporal paradox caught: Device clock appears back-dated. Denying discount evaluate.");
        return false;
      }

      final int daysAway = currentDeviceTime.difference(lastLogin).inDays;

      if (daysAway >= 14) {
        debugPrint("🚨 Win-Back Signal Verified: User absence calculated at $daysAway days. Triggering promo.");
        return true;
      }
    } catch (e) {
      debugPrint("❌ Promo Engine Fallback Silently: ${e.toString()}");
    }
    
    return false;
  }
}
