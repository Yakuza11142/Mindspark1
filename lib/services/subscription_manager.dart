import 'package:in_app_purchase/in_app_purchase.dart';

class SubscriptionManager {
  static Future<void> restorePurchases() async {
    await InAppPurchase.instance.restorePurchases();
  }
}