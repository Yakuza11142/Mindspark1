import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// FIXED: Updated package namespace targets from template strings to your concrete project name
import 'package:mindspark1/ad_manager.dart';
import 'package:mindspark1/secure_banner_container.dart';

/// Minimal testing mock stub implementation to bypass native Google platform initializers
class MockAdManager implements AdManager {
  late BannerAd capturedAdInstance;
  late VoidCallback mockFailureTrigger;

  @override
  void init() {}

  @override
  BannerAd createManagedBanner({required VoidCallback onAdFailed}) {
    mockFailureTrigger = onAdFailed;

    capturedAdInstance = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, error) => onAdFailed(),
      ),
    );
    return capturedAdInstance;
  }

  @override
  void showSmartInterstitial() {}

  @override
  void showRewarded({required VoidCallback onRewardEarned, required VoidCallback onAdUnavailable}) {}

  @override
  void dispose() {}
}

void main() {
  group('SecureBannerContainer Layout Integrity Tests', () {
    late MockAdManager mockAdManager;
    const String adChannelName = 'plugins.flutter.io/google_mobile_ads';

    Widget buildTestHarness() {
      return MaterialApp(
        home: Scaffold(
          body: SecureBannerContainer(adManager: mockAdManager),
        ),
      );
    }

    testWidgets('Should render a persistent loading placeholder on baseline initialization', (WidgetTester tester) async {
      mockAdManager = MockAdManager();

      // SUCCESS: Valid messenger handler block aligns flawlessly with test suites
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        const MethodChannel(adChannelName),
        (MethodCall methodCall) async {
          if (methodCall.method == 'createAd') return null; 
          if (methodCall.method == 'initialize') return <dynamic, dynamic>{};
          return null;
        },
      );

      // Registers a localized teardown to preserve channel safety
      addTearDown(() {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
          const MethodChannel(adChannelName),
          null,
        );
      });

      await tester.pumpWidget(buildTestHarness());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(AdWidget), findsNothing);
    });

    testWidgets('Should silently collapse container box profiles to zero when loading fails', (WidgetTester tester) async {
      mockAdManager = MockAdManager();

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        const MethodChannel(adChannelName),
        (MethodCall methodCall) async {
          if (methodCall.method == 'createAd') return null; 
          if (methodCall.method == 'initialize') return <dynamic, dynamic>{};
          return null;
        },
      );

      addTearDown(() {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
          const MethodChannel(adChannelName),
          null,
        );
      });

      await tester.pumpWidget(buildTestHarness());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Act: Force-trigger our failure parameter path mock callback synchronously
      mockAdManager.mockFailureTrigger();

      // Allowed layout transitions and state timelines to completely settle
      await tester.pumpAndSettle();

      // Assert: Elements must wipe clean cleanly without throwing sizing boundary errors
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(AdWidget), findsNothing);
      
      // SUCCESS: Safely queries layout box metrics to verify complete closure tracking
      final RenderBox box = tester.renderObject(find.byType(SecureBannerContainer));
      expect(box.hasSize ? box.size : Size.zero, equals(Size.zero));
    });
  });
}
