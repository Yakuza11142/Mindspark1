import 'package:test/test.dart';
// FIXED: Updated package namespace from template placeholders to your concrete project name
import 'package:mindspark1/oracle_sync_engine.dart'; 

void main() {
  group('OracleSyncEngine Precision and State Transformations', () {
    late OracleSyncEngine engine;

    setUp(() {
      engine = OracleSyncEngine();
    });

    test('Initial properties match baseline defaults', () {
      expect(engine.inferredState, equals(CognitiveLoadState.receptive));
      expect(engine.entropyScore, equals(1.0));
    });

    test('Floating-point operations clamp values to exactly 3 decimal places', () {
      engine.logMicroInteractionTelemetry(gazeDwellTimeSeconds: 0.0, vectorHesitationIndex: 1.0, acousticPitchDelta: []);
      engine.logMicroInteractionTelemetry(gazeDwellTimeSeconds: 0.0, vectorHesitationIndex: 1.0, acousticPitchDelta: []);
      engine.logMicroInteractionTelemetry(gazeDwellTimeSeconds: 0.0, vectorHesitationIndex: 0.0, acousticPitchDelta: []);

      expect(engine.entropyScore, equals(0.667));
    });

    test('Sliding ring buffer drops historical packets once it hits capacity limits', () {
      // Step 1: Fill the buffer entirely with 50 items of 0.0
      for (int i = 0; i < 50; i++) {
        engine.logMicroInteractionTelemetry(gazeDwellTimeSeconds: 0.0, vectorHesitationIndex: 0.0, acousticPitchDelta: []);
      }
      expect(engine.entropyScore, equals(0.0));

      // Step 2: Push exactly 10 items of 1.0 to force out 10 items of 0.0
      for (int i = 0; i < 10; i++) {
        engine.logMicroInteractionTelemetry(gazeDwellTimeSeconds: 0.0, vectorHesitationIndex: 1.0, acousticPitchDelta: []);
      }

      // 40 items of 0.0 + 10 items of 1.0 = 10.0 sum. 10 / 50 = 0.200
      expect(engine.entropyScore, equals(0.2));
    });

    test('Notifications only fire when state or rounded score changes', () {
      int notifyCount = 0;
      engine.addListener(() => notifyCount++);

      engine.logMicroInteractionTelemetry(gazeDwellTimeSeconds: 0.0, vectorHesitationIndex: 0.5, acousticPitchDelta: []);
      expect(notifyCount, equals(1));

      engine.logMicroInteractionTelemetry(gazeDwellTimeSeconds: 0.0, vectorHesitationIndex: 0.5, acousticPitchDelta: []);
      expect(notifyCount, equals(1));
    });

    test('resetEngine systematically wipes state machine fields back to zero configurations', () {
      engine.logMicroInteractionTelemetry(gazeDwellTimeSeconds: 0.5, vectorHesitationIndex: 0.99, acousticPitchDelta: []);

      engine.resetEngine();

      expect(engine.inferredState, equals(CognitiveLoadState.receptive));
      expect(engine.entropyScore, equals(1.0));
    });
  });
}
