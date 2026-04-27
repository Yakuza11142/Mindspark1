import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../config/secrets.dart';

class PaymentService {
  final InAppPurchase _iap = InAppPurchase.instance;
  Function(bool)? onProStatusChanged;

  void init() {
    _iap.purchaseStream.listen((list) {
      for (var p in list) {
        if (p.status == PurchaseStatus.purchased || p.status == PurchaseStatus.restored) {
          if (onProStatusChanged != null) onProStatusChanged!(true);
        }
      }
    });
  }

  Future<void> buyPro() async {
    if (!(await _iap.isAvailable())) return;
    final res = await _iap.queryProductDetails({Secrets.productId});
    if (res.productDetails.isNotEmpty) {
      _iap.buyNonConsumable(purchaseParam: PurchaseParam(productDetails: res.productDetails.first));
    }
  }
}