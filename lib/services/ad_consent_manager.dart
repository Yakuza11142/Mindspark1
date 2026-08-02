import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// Replace with your actual project layout namespace
import 'package:your_project_name/privacy_settings_button.dart';

void main() {
  group('PrivacySettingsButton Interaction Verification Tests', () {
    Widget buildTestHarness() {
      return const MaterialApp(
        home: Scaffold(
          body: PrivacySettingsButton(),
        ),
      );
    }

    testWidgets('Should display standard navigation layouts on baseline initialization', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestHarness());

      expect(find.text('Privacy & Cookie Preferences'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      
      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.enabled, isTrue);
    });

    testWidgets('Should lock out input channels and spin loading indicators when pressed', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestHarness());

      // Safely manage native platform asynchronous side-effects 
      await tester.runAsync(() async {
        await tester.tap(find.byType(ListTile));
      });
      
      // FIX: Pump the layout tree outside the async block to ensure perfect frame sync
      await tester.pump();

      // Assert interaction constraints lock down securely
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsNothing);
      
      final disabledListTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(disabledListTile.enabled, isFalse);
    });
  });
}
