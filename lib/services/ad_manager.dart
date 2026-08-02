import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// Replace with your actual project layout namespace
import 'package:your_project_name/ad_manager.dart';
import 'package:your_project_name/secure_banner_container.dart';

/// Minimal testing mock stub implementation to bypass native Google platform initializers
class MockAdManager implements AdManager {
  late BannerAd capturedAdInstance;
  late VoidCallback mockFailureTrigger;

  @override
  void init() {}

  @override
  BannerAd createManagedBanner({required VoidCallback onAdFailed}) {
    mockFailureTrigger = onAdFailed;
    
    // Instantiate the container using industry-standard mock unit codes
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
  // Safe platform-level engine channel initialization binding rule
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SecureBannerContainer Layout Integrity Tests', () {
    late MockAdManager mockAdManager;
    const String adChannelName = 'plugins.flutter.io/google_mobile_ads';

    setUp(() {
      mockAdManager = MockAdManager();

      // Safely intercept native AdMob SDK method calls to isolate test execution
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(const MethodChannel(adChannelName), (MethodCall methodCall) async {
        if (methodCall.method == 'createAd') {
          return null; 
        }
        if (methodCall.method == 'initialize') {
          // Return expected type map structures to align with SDK specifications
          return <dynamic, dynamic>{};
        }
        return null;
      });
    });

    tearDown(() {
      // Clean up the channel mock registry after each test execution run
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(const MethodChannel(adChannelName), null);
    });

    Widget buildTestHarness() {
      return MaterialApp(
        home: Scaffold(
          body: SecureBannerContainer(adManager: mockAdManager),
        ),
      );
    }

    testWidgets('Should render a persistent loading placeholder on baseline initialization', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestHarness());

      // Assert: Verify that structural placeholders mount correctly while fetching network streams
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(AdWidget), findsNothing);
    });

    testWidgets('Should silently collapse container box profiles to zero when loading fails', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestHarness());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Act: Force-trigger our failure parameter path mock callback synchronously
      mockAdManager.mockFailureTrigger();
      
      // Re-evaluate layout changes inside the state thread
      await tester.pump();

      // Assert: Elements must wipe clean cleanly without throwing sizing boundary errors
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(AdWidget), findsNothing);
      expect(find.byType(SizedBox), findsOneWidget); 
    });
  });
}
