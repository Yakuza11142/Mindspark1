import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
// FIXED: Updated package namespace from template placeholders to your concrete project name
import 'package:mindspark1/achievement_service.dart';

void main() {
  // Safe platform-level engine channel initialization binding rule
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AchievementService Comprehensive Unit Tests', () {
    const String storageKey = 'achievements';
    const String kiloMilestone = 'spark_kilo_achiever';
    const String megaMilestone = 'spark_mega_achiever';

    setUp(() {
      // Clears the global mock storage database back to empty before each test block runs
      SharedPreferences.setMockInitialValues({});
    });

    test('Should initialize with an empty cache when no disk data exists', () async {
      final service = await AchievementService.create();
      expect(service.isUnlocked(kiloMilestone), isFalse);
    });

    test('Should populate cache smoothly when historic data exists on disk', () async {
      // Pre-seed storage via standard, framework-validated configuration maps
      SharedPreferences.setMockInitialValues({
        storageKey: [kiloMilestone],
      });

      final service = await AchievementService.create();

      expect(service.isUnlocked(kiloMilestone), isTrue);
      expect(service.isUnlocked(megaMilestone), isFalse);
    });

    test('Should skip unlock sequence if totalSparks score is under threshold', () async {
      final service = await AchievementService.create();
      bool callbackFired = false;

      await service.checkMilestones(
        totalSparks: 500,
        onNewUnlockTriggered: () => callbackFired = true,
      );

      expect(service.isUnlocked(kiloMilestone), isFalse);
      expect(callbackFired, isFalse);
    });

    test('Should trigger callback and persist to disk when threshold is crossed', () async {
      final service = await AchievementService.create();
      bool callbackFired = false;

      await service.checkMilestones(
        totalSparks: 1200,
        onNewUnlockTriggered: () => callbackFired = true,
      );

      expect(service.isUnlocked(kiloMilestone), isTrue);
      expect(callbackFired, isTrue);

      final prefs = await SharedPreferences.getInstance();
      final diskData = prefs.getStringList(storageKey);
      expect(diskData, contains(kiloMilestone));
    });

    test('Should prevent redundant duplicate triggers if milestone is already unlocked', () async {
      final service = await AchievementService.create();
      int triggerCount = 0;

      await service.checkMilestones(
        totalSparks: 1000,
        onNewUnlockTriggered: () => triggerCount++,
      );

      await service.checkMilestones(
        totalSparks: 1500,
        onNewUnlockTriggered: () => triggerCount++,
      );

      expect(triggerCount, equals(1));
    });
  });
}
