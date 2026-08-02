import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Replace with your actual project layout namespace
import 'package:your_project_name/ad_frequency_capper.dart';

void main() {
  // Safe platform-level engine channel initialization binding rule
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AdFrequencyCapper Comprehensive Unit Tests', () {
    const String countKey = 'ad_frequency_daily_count';
    const String dateKey = 'ad_frequency_last_shown_date';

    // Helper utility method to dynamically generate current ISO calendar keys (e.g. "2026-08-02")
    String _getSafeCurrentDateString() {
      final now = DateTime.now();
      return "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    }

    setUp(() {
      // Clear out global static preference maps before each test block runs
      SharedPreferences.setMockInitialValues({});
    });

    test('Should initialize with a clean zero baseline when no disk history exists', () async {
      final capper = await AdFrequencyCapper.create();

      expect(capper.currentDailyCount, equals(0));
      expect(capper.canShowAd(), isTrue);
    });

    test('Should accurately load tracking states from disk properties during boot sequence', () async {
      final String safeToday = _getSafeCurrentDateString();
      SharedPreferences.setMockInitialValues({
        countKey: 4,
        dateKey: safeToday,
      });

      final capper = await AdFrequencyCapper.create();

      expect(capper.currentDailyCount, equals(4));
      expect(capper.lastShownDateString, equals(safeToday));
      expect(capper.canShowAd(), isTrue);
    });

    test('Should isolate verification checks from state increment mutations', () async {
      final capper = await AdFrequencyCapper.create();
      
      // Call pure query checks sequentially 
      expect(capper.canShowAd(), isTrue);
      expect(capper.canShowAd(), isTrue);

      // Verify that counter remains completely unaffected by query inspections
      expect(capper.currentDailyCount, equals(0));
    });

    test('Should update persistence layer and enforce lockout restrictions when daily cap is reached', () async {
      final capper = await AdFrequencyCapper.create();

      // Trigger consecutive impressions right up to the boundary limit
      for (int i = 0; i < 10; i++) {
        expect(capper.canShowAd(), isTrue);
        await capper.incrementAdCount();
      }

      // Assert that capping limits hold securely
      expect(capper.currentDailyCount, equals(10));
      expect(capper.canShowAd(), isFalse);

      // Verify immediate structural disk persistence mutations
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt(countKey), equals(10));
    });

    test('Should automatically drop counts back to zero when a midnight calendar roll is detected', () async {
      SharedPreferences.setMockInitialValues({
        countKey: 10,
        dateKey: '2020-01-01', // Historical past date string
      });

      // Fixed Rollover Test: Initializing triggers our boot synchronization update rules instantly
      final capper = await AdFrequencyCapper.create();

      expect(capper.currentDailyCount, equals(0));
      expect(capper.canShowAd(), isTrue);
      expect(capper.lastShownDateString, equals(_getSafeCurrentDateString()));
    });
  });
}
