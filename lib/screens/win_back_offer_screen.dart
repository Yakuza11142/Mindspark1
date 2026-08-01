
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'dart:developer' as developer;

class WinBackOfferScreen extends StatefulWidget {
  const WinBackOfferScreen({super.key});

  @override
  State<WinBackOfferScreen> createState() => _WinBackOfferScreenState();
}

class _WinBackOfferScreenState extends State<WinBackOfferScreen> {
  // Central product ID definitions linked to your App Store / Play Console developer panels
  static const String _discountedProductId = 'mindspark_pro_winback_50';
  final InAppPurchase _iapEngine = InAppPurchase.instance;

  ProductDetails? _fetchedProduct;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Fetch live storefront pricing parameters immediately upon view layer initialization
    _fetchStoreProductDetails();
  }

  /// Handshakes with the underlying OS billing engines to extract localized prices securely
  Future<void> _fetchStoreProductDetails() async {
    developer.log("💰 WinBackOffer: Querying active localized storefront prices from app market api.");
    try {
      final bool isStoreAvailable = await _iapEngine.isAvailable();
      if (!isStoreAvailable) {
        developer.log("⚠️ WinBackOffer: Native billing microservice is currently inaccessible.");
        if (mounted) setState(() => _isLoading = false);
        return;
      }

      // Fetch the true, un-spoofable regional billing configuration natively
      final ProductDetailsResponse response = await _iapEngine.queryProductDetails({
        _discountedProductId,
      }).timeout(const Duration(seconds: 6));

      if (response.notFoundIDs.contains(_discountedProductId) || response.productDetails.isEmpty) {
        developer.log("❄️ WinBackOffer: Promotional Product ID lookup returned empty records.");
      } else {
        _fetchedProduct = response.productDetails.first;
      }
    } catch (e, stackTrace) {
      developer.log("❌ WinBackOffer: Billing handshake channel collapsed seamlessly", error: e, stackTrace: stackTrace);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// Dispatches the secure localized purchase intent sheet to the device storefront
  Future<void> _triggerPurchaseTransaction() async {
    if (_fetchedProduct == null) return;
    
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: _fetchedProduct!);
    try {
      developer.log("🚀 WinBackOffer: Launching native purchase checkout overlay panel.");
      await _iapEngine.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e, stackTrace) {
      developer.log("❌ WinBackOffer: Purchase initialization failed", error: e, stackTrace: stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF4A148C), // Replaced with an explicit, efficient background color constant
        body: Center(child: CircularProgressIndicator(color: Colors.amber)),
      );
    }

    // Extracted the un-spoofable localized price string dynamically (e.g., '₦2,250', '$4.99', '£4.99')
    final String storefrontPriceString = _fetchedProduct?.price ?? "50% OFF";

    return Scaffold(
      backgroundColor: const Color(0xFF4A148C), // FIXED: Enforced a strict compile-time constant hex color layout
      body: Center(
        child: SingleChildScrollView( // Prevents viewport clipping and yellow display bars on low-res screens
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_fire_department, size: 100, color: Colors.amber),
              const SizedBox(height: 20),
              const Text(
                "WE MISSED YOU.",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text(
                "It's been 14 days. Your competition is studying. We want you back in the game.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
              const SizedBox(height: 40),
              const Text(
                "SPECIAL OFFER",
                style: TextStyle(color: Colors.amber, letterSpacing: 2, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                "Get MindSpark Pro at 50% Off.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                "ONLY $storefrontPriceString FOR YOUR FIRST MONTH",
                style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _fetchedProduct != null ? _triggerPurchaseTransaction : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  disabledBackgroundColor: Colors.white10,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 10,
                ),
                child: Text(
                  _fetchedProduct != null ? "CLAIM 50% OFF NOW" : "PROMOTION UNAVAILABLE",
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "SECURE ENCRYPTED CHECKOUT VIA APPMARKET",
                style: TextStyle(color: Colors.white24, fontSize: 9, letterSpacing: 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
