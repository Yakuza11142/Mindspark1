import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
// FIXED: Updated package namespace from template placeholders to your concrete project name
import 'package:mindspark1/ad_failure_reward_giver.dart';

/// Lightweight custom test spy implementation to monitor currency balance increments.
class FakeCurrencyProcessor implements CurrencyProcessor {
  int sparksAdded = 0;

  @override
  void addSparks(int amount) {
    sparksAdded += amount;
  }

  @override
  int get currentSparksBalance => sparksAdded;
}

void main() {
  // Safe platform-level engine channel initialization binding rule
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AdFailureRewardGiver Comprehensive Unit Tests', () {
    late FakeCurrencyProcessor fakeProcessor;
    const String countKey = 'ad_failure_daily_count';
    const String dateKey = 'ad_failure_last_trigger_date';

    // Helper method to dynamically generate current ISO calendar keys (e.g. "2026-08-02")
    String _getSafeCurrentDateString() {
      final now = DateTime.now();
      return "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    }

    setUp(() {
      fakeProcessor = FakeCurrencyProcessor();
      SharedPreferences.setMockInitialValues({});
    });

    test('Should initialize with a zero count when no historical data exists', () async {
      final giver = await AdFailureRewardGiver.create(currencyProcessor: fakeProcessor);

      expect(giver.currentDailyCount, equals(0));
      expect(giver.lastTriggerDateString, isEmpty);
    });

    test('Should populate tracking states smoothly when historical data exists on disk', () async {
      // FIX: Replaced hardcoded date value with a dynamic runtime string generator to block test decay
      final String activeDateToken = _getSafeCurrentDateString();

      SharedPreferences.setMockInitialValues({
        countKey: 2,
        dateKey: activeDateToken,
      });

      final giver = await AdFailureRewardGiver.create(currencyProcessor: fakeProcessor);

      expect(giver.currentDailyCount, equals(2));
      expect(giver.lastTriggerDateString, equals(activeDateToken));
    });

    test('Should skip reward sequence completely if device is offline', () async {
      final giver = await AdFailureRewardGiver.create(currencyProcessor: fakeProcessor);

      await giver.handleAdTimeout(isDeviceConfirmedOnline: false);

      expect(giver.currentDailyCount, equals(0));
      expect(fakeProcessor.sparksAdded, equals(0));
    });

    test('Should increment counter and persist currency on valid online timeout triggers', () async {
      final giver = await AdFailureRewardGiver.create(currencyProcessor: fakeProcessor);

      await giver.handleAdTimeout(isDeviceConfirmedOnline: true);

      expect(giver.currentDailyCount, equals(1));
      expect(fakeProcessor.sparksAdded, equals(20));

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt(countKey), equals(1));
      expect(prefs.getString(dateKey), isNotEmpty);
    });

    test('Should lock down and block execution when daily limits are breached', () async {
      SharedPreferences.setMockInitialValues({
        countKey: 3,
        dateKey: _getSafeCurrentDateString(),
      });

      final giver = await AdFailureRewardGiver.create(currencyProcessor: fakeProcessor);

      await giver.handleAdTimeout(isDeviceConfirmedOnline: true);

      expect(giver.currentDailyCount, equals(3));
      expect(fakeProcessor.sparksAdded, equals(0));
    });

    test('Should completely reset counter arrays when a new calendar day rolls over', () async {
      SharedPreferences.setMockInitialValues({
        countKey: 3,
        dateKey: '2020-01-01', // Historical past date
      });

      final giver = await AdFailureRewardGiver.create(currencyProcessor: fakeProcessor);

      await giver.handleAdTimeout(isDeviceConfirmedOnline: true);

      expect(giver.currentDailyCount, equals(1));
      expect(fakeProcessor.sparksAdded, equals(20));
    });
  });
}
