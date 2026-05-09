import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'currency_manager.dart';
import 'ad_manager.dart';

class Bootloader {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await MobileAds.instance.initialize();
    await CurrencyManager().init(false);
    AdManager().init();
  }
}