import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// FIXED: Updated package namespace from template placeholders to your concrete project name
import 'package:mindspark1/spatial_network_guard.dart';
import 'package:mindspark1/spatial_pipeline_observer.dart';

void main() {
  group('SpatialPipelineObserver UI Integration Tests', () {
    late SpatialNetworkGuard fakeGuard;

    const double testLayoutWidth = 400.0;
    const double testLayoutHeight = 300.0;

    final Widget greenCloudView = Container(
      key: const Key('cloud_view'),
      color: Colors.green,
    );

    final Widget blueLocalView = Container(
      key: const Key('local_view'),
      color: Colors.blue,
    );

    setUp(() {
      fakeGuard = SpatialNetworkGuard();
    });

    tearDown(() {
      // Clean up internal resources to guarantee clear event loops across tests
      fakeGuard.dispose();
    });

    Widget buildTestHarness() {
      return MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: testLayoutWidth,
            height: testLayoutHeight,
            child: SpatialPipelineObserver(
              networkGuard: fakeGuard,
              cloudRenderChild: greenCloudView,
              localEngineChild: blueLocalView,
            ),
          ),
        ),
      );
    }

    testWidgets('Should render the cloud viewport by default when network state initializes', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestHarness());

      expect(find.byKey(const Key('cloud_view')), findsOneWidget);
      expect(find.byKey(const Key('local_view')), findsNothing);
      expect(find.text('0.0 ms'), findsOneWidget);
    });

    testWidgets('Should transition view frames cleanly to local fallback state on bad ping spikes', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestHarness());

      // Saturate the moving average window to simulate stable network degradation
      for (int i = 0; i < 5; i++) {
        fakeGuard.reportFrameDeliveryMetrics(250.0);
      }

      await tester.pump();

      expect(find.byKey(const Key('cloud_view')), findsNothing);
      expect(find.byKey(const Key('local_view')), findsOneWidget);
      expect(find.text('250.0 ms'), findsOneWidget);
    });

    testWidgets('Should display connection stalled view when moving average drops to zero', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestHarness());

      // Inject clear stall signal to simulate drop-off thresholds safely
      fakeGuard.reportFrameDeliveryMetrics(0.0);
      await tester.pump();

      expect(find.byKey(const Key('cloud_view')), findsNothing);
      expect(find.byKey(const Key('local_view')), findsNothing);
      expect(find.text('Connection Stalled'), findsOneWidget);
      expect(find.byIcon(Icons.cloud_off), findsOneWidget);
    });
  });
}
