import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:area_and_volume/main.dart';

void main() {
  testWidgets('Check for presence of main elements on the landing page',
      (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const AreaAndVolumeApp());

    // Verify that the title is present.
    expect(find.text('Area and Volume'), findsOneWidget);

    // Verify that the buttons are present.
    expect(find.text('Learn'), findsOneWidget);
    expect(find.text('Practice'), findsOneWidget);
    expect(find.text('Play'), findsOneWidget);

    // Verify that the toggle switch is present.
    expect(find.byType(Switch), findsOneWidget);
  });

  testWidgets('Toggle language switch', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const AreaAndVolumeApp());

    // Verify that the default language is English.
    expect(find.text('Area and Volume'), findsOneWidget);
    expect(find.text('Learn'), findsOneWidget);

    // Toggle the switch to change the language to Spanish.
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    // Verify that the text changes to Spanish.
    expect(find.text('Área y volumen'), findsOneWidget);
    expect(find.text('Aprender'), findsOneWidget);
  });
}
