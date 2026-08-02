import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_async/fake_async.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// Replace with your actual project layout namespace
import 'package:your_project_name/admob_global_waterfall.dart';

void main() {
  // Safe platform-level engine channel initialization binding rule
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AdmobGlobalWaterfall Advanced Pipeline Tests', () {
    const String adChannelName = 'plugins.flutter.io/google_mobile_ads';
    final List<String> fakeTiers = ['high_floor', 'medium_floor', 'backfill_floor'];
    late AdmobGlobalWaterfall waterfall;

    setUp(() {
      waterfall = AdmobGlobalWaterfall(adUnits: fakeTiers);
    });

    tearDown(() {
      // FIXED REGISTRY BUG: Explicitly clear the channel mock registry after each execution block
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(const MethodChannel(adChannelName), null);
    });

    test('Should execute cascade fallback when upper tiers return structural errors', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(const MethodChannel(adChannelName), (MethodCall methodCall) async {
        if (methodCall.method == 'initialize') return <dynamic, dynamic>{};
        if (methodCall.method == 'createAd') {
          final Map<dynamic, dynamic> args = methodCall.arguments as Map<dynamic, dynamic>;
          final int adId = args['adId'] as int;
          final String unitId = args['adUnitId'] as String;

          if (unitId == 'backfill_floor') {
            Future.microtask(() {
              TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.handlePlatformMessage(
                adChannelName,
                const StandardMethodCodec().encodeMethodCall(MethodCall('onAdLoaded', {'adId': adId})),
                null,
              );
            });
            return null;
          }

          Future.microtask(() {
            TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.handlePlatformMessage(
              adChannelName,
              const StandardMethodCodec().encodeMethodCall(MethodCall('onAdFailedToLoad', {
                'adId': adId,
                'loadAdError': {'code': 3, 'domain': 'ads', 'message': 'No Fill'}
              })),
              null,
            );
          });
          return null;
        }
        return null;
      });

      int? resolvedIndex;
      await waterfall.executeWaterfallOrchestration(
        onSuccess: (ad, index) => resolvedIndex = index,
        onFailure: (error) => fail('Waterfall orchestration should have completed successfully on backfill.'),
      );

      expect(resolvedIndex, equals(2)); 
    });

    test('Should trigger timeout exception and step to next tier if a request hangs past 4 seconds', () {
      fakeAsync((async) {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(const MethodChannel(adChannelName), (MethodCall methodCall) async {
          if (methodCall.method == 'initialize') return <dynamic, dynamic>{};
          if (methodCall.method == 'createAd') {
            final Map<dynamic, dynamic> args = methodCall.arguments as Map<dynamic, dynamic>;
            final int adId = args['adId'] as int;
            final String unitId = args['adUnitId'] as String;

            if (unitId == 'medium_floor') {
              // Wrap with zone-aware timer triggers to align perfectly with fakeAsync virtual clocks
              Timer(const Duration(seconds: 2), () {
                TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.handlePlatformMessage(
                  adChannelName,
                  const StandardMethodCodec().encodeMethodCall(MethodCall('onAdLoaded', {'adId': adId})),
                  null,
                );
              });
            }
            return null;
          }
          return null;
        });

        int? resolvedIndex;
        waterfall.executeWaterfallOrchestration(
          onSuccess: (ad, index) => resolvedIndex = index,
          onFailure: (error) => fail('Should have found an asset on the secondary tier.'),
        );

        // Virtual Time Travel: Instantly advance the mock timeline to trigger the first-tier timeout
        async.elapse(const Duration(milliseconds: 4100));

        expect(resolvedIndex, equals(1)); 
      });
    });
  });
}
