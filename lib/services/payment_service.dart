import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';

class PaymentService {
  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  Function(bool)? onProStatusChanged;

  // Reads from compile-time secrets.json (--dart-define-from-file)
  static const String _productId = String.fromEnvironment(
    'PRODUCT_ID',
    defaultValue: 'mindspark_pro_monthly',
  );

  void init() {
    _subscription = _iap.purchaseStream.listen(
      (List<PurchaseDetails> purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      },
      onDone: () {
        _subscription?.cancel();
      },
      onError: (error) {
        // Handle stream error
      },
    );
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        if (purchaseDetails.pendingCompletePurchase) {
          _iap.completePurchase(purchaseDetails);
        }
        if (onProStatusChanged != null) {
          onProStatusChanged!(true);
        }
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        if (purchaseDetails.pendingCompletePurchase) {
          _iap.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<void> buyPro() async {
    final bool available = await _iap.isAvailable();
    if (!available) return;

    final ProductDetailsResponse response =
        await _iap.queryProductDetails({_productId});

    if (response.notFoundIDs.isNotEmpty) {
      return;
    }

    if (response.productDetails.isNotEmpty) {
      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: response.productDetails.first);

      await _iap.buyNonConsumable(purchaseParam: purchaseParam);
    }
  }

  void dispose() {
    _subscription?.cancel();
  }
}
