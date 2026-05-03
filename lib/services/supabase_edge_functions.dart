import '../config/supabase_core_config.dart';

class SupabaseEdgeFunctions {
  static Future<bool> verifyGoogleReceipt(String receiptToken) async {
    try {
      final res = await SupabaseCoreConfig.client.functions.invoke(
        'verify_play_store_receipt',
        body: {'receipt': receiptToken},
      );
      return res.data['is_valid'] == true;
    } catch (e) {
      return false;
    }
  }
}