import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
// FIXED: Updated package namespace from template placeholders to your concrete project name
import 'package:mindspark1/active_recall_scheduler.dart';

void main() {
  // Safe platform-level engine channel initialization binding rule
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    tz_data.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('UTC'));
  });

  group('ActiveRecallScheduler Comprehensive Unit Tests', () {
    const String storageKey = 'active_recall_sessions_manifest';

    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('Should initialize with an empty cache list when no historical data exists', () async {
      final scheduler = await ActiveRecallScheduler.create();

      expect(scheduler.activeSessions, isEmpty);
    });

    test('Should populate cache smoothly when historical serialization exists on disk', () async {
      final String safeTimeAnchor = DateTime.now().add(const Duration(hours: 12)).toIso8601String();

      SharedPreferences.setMockInitialValues({
        storageKey: '[{"id":12345,"topic":"Flutter Hooks","scheduledTime":"$safeTimeAnchor","interval":"daily"}]',
      });

      final scheduler = await ActiveRecallScheduler.create();

      expect(scheduler.activeSessions.length, equals(1));
      expect(scheduler.activeSessions.first.topic, equals('Flutter Hooks'));
      expect(scheduler.activeSessions.first.id, equals(12345));
    });

    test('Should successfully append to storage and cache when a new session is scheduled', () async {
      final scheduler = await ActiveRecallScheduler.create();

      await scheduler.scheduleRecallSession(
        topic: 'Dart Isolates',
        interval: SpacedInterval.immediate,
      );

      expect(scheduler.activeSessions.length, equals(1));
      expect(scheduler.activeSessions.first.topic, equals('Dart Isolates'));
      expect(scheduler.activeSessions.first.interval, equals(SpacedInterval.immediate));

      final prefs = await SharedPreferences.getInstance();
      final String? rawJson = prefs.getString(storageKey);
      expect(rawJson, isNotNull);
      expect(rawJson, contains('Dart Isolates'));
    });

    test('Should enforce safety parameters and throw an ArgumentError on blank entries', () async {
      final scheduler = await ActiveRecallScheduler.create();

      expect(
        () => scheduler.scheduleRecallSession(topic: '   ', interval: SpacedInterval.daily),
        throwsArgumentError,
      );
    });

    test('Should securely wipe past notification entries upon calling maintenance cleaners', () async {
      // FIXED ENGINE RACE CONDITION: Initialize your async scheduler instance first
      final scheduler = await ActiveRecallScheduler.create();

      // Calculate time metrics immediately before assigning maps to block out thread jitter
      final DateTime historicalPast = DateTime.now().subtract(const Duration(hours: 5));
      final DateTime futureTarget = DateTime.now().add(const Duration(hours: 5));

      SharedPreferences.setMockInitialValues({
        storageKey: '[{"id":1,"topic":"Past Topic","scheduledTime":"${historicalPast.toIso8601String()}","interval":"immediate"},'
                     '{"id":2,"topic":"Future Topic","scheduledTime":"${futureTarget.toIso8601String()}","interval":"daily"}]',
      });

      // Force a manual data refresh on the existing instances
      // (Or re-create the service to test serialization mapping bounds directly)
      final activeInstance = await ActiveRecallScheduler.create();
      expect(activeInstance.activeSessions.length, equals(2));

      await activeInstance.cleanExpiredSessions();

      expect(activeInstance.activeSessions.length, equals(1));
      expect(activeInstance.activeSessions.first.topic, equals('Future Topic'));
    });
  });
}
