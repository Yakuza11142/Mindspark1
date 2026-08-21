import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeAdView extends StatelessWidget {
  const NativeAdView({super.key});

  @override
  Widget build(BuildContext context) {
    // Renders the raw native Android or iOS Ad Layout directly in the Flutter widget tree
    if (Theme.of(context).platform == TargetPlatform.android) {
      return const AndroidView(viewType: 'com.mindspark.app/ad_banner_view');
    } else {
      return const UiKitView(viewType: 'com.mindspark.app/ad_banner_view');
    }
  }
}
