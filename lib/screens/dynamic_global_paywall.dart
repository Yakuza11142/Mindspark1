import 'package:flutter/material.dart';
import '../engines/ppp_pricing_engine.dart';
import '../services/fx_rate_fetcher.dart';
import 'dart:ui' as ui;

class DynamicGlobalPaywall extends StatefulWidget {
  final String userCountryIso; // e.g., 'NG', 'US', 'IN'
  final String targetExam;     // e.g., 'JAMB', 'SAT', 'JEE'
  const DynamicGlobalPaywall({super.key, required this.userCountryIso, required this.targetExam});

  @override
  State<DynamicGlobalPaywall> createState() => _DynamicGlobalPaywallState();
}

class _DynamicGlobalPaywallState extends State<DynamicGlobalPaywall> {
  String localPriceString = "Loading...";

  @override
  void initState() {
    super.initState();
    _calculateLocalPrice();
  }

  void _calculateLocalPrice() async {
    double usdPrice = PppPricingEngine.getOptimalPriceUsd(widget.userCountryIso);
    
    // Attempt to get local currency code from device
    String currencyCode = "USD";
    try {
      currencyCode = ui.PlatformDispatcher.instance.locale.countryCode ?? "US";
      // This is a simplified mapping. Real app uses package:currency_picker or similar.
      if (widget.userCountryIso == 'NG') currencyCode = 'NGN';
      if (widget.userCountryIso == 'IN') currencyCode = 'INR';
      if (widget.userCountryIso == 'GB') currencyCode = 'GBP';
    } catch (_) {}

    double fxRate = await FxRateFetcher.getRate(currencyCode);
    double finalPrice = usdPrice * fxRate;
    
    setState(() {
      // Basic formatting for demo
      localPriceString = "$currencyCode ${finalPrice.toStringAsFixed(2)} / month";
      if (currencyCode == 'NGN') localPriceString = "₦${finalPrice.round()} / month";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Icon(Icons.diamond, size: 80, color: Colors.cyanAccent),
            const SizedBox(height: 20),
            Text("CRUSH THE ${widget.targetExam}", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
            const Text("Unlock Pro AI & 3D Holo-Deck", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 40),
            Text(localPriceString, style: const TextStyle(fontSize: 36, color: Colors.amber, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
              onPressed: () {}, // Trigger Google IAP here
              child: const Text("SUBSCRIBE NOW", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}