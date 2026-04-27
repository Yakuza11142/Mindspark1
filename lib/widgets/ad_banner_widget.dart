import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/ad_manager.dart';

class AdBannerWidget extends StatefulWidget {
  const AdBannerWidget({super.key});
  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  BannerAd? _ad;
  @override
  void initState() {
    super.initState();
    _ad = AdManager().createBanner()..load();
  }
  @override
  Widget build(BuildContext context) {
    if (_ad == null) return const SizedBox.shrink();
    return SizedBox(width: _ad!.size.width.toDouble(), height: _ad!.size.height.toDouble(), child: AdWidget(ad: _ad!));
  }
}