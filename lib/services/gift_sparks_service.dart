import 'currency_manager.dart';

class GiftSparksService {
  static Future<bool> sendGift(CurrencyManager manager, int amount) async {
    return await manager.spendSparks(amount);
    // In real backend, add to friend's account here
  }
}