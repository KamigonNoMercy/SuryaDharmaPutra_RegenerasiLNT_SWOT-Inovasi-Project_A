
import 'package:flutter_test/flutter_test.dart';

import 'package:calculator/main.dart';

void main() {
  testWidgets('Calculator UI test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(CalculatorApp());

    // Verify that the initial output is '0'.
    expect(find.text('0'), findsOneWidget);

    // Tap the buttons and verify the output changes accordingly.
    await tapButton(tester, '1');
    expect(find.text('1'), findsOneWidget);

    await tapButton(tester, '+');
    expect(find.text('0'), findsOneWidget); // Verify the operator clears the display

    await tapButton(tester, '2');
    expect(find.text('2'), findsOneWidget);

    await tapButton(tester, '=');
    expect(find.text('3'), findsOneWidget); // Verify the calculation result

    await tapButton(tester, 'C');
    expect(find.text('0'), findsOneWidget); // Verify the clear operation
  });
}

// Helper function to tap a button with the given label.
Future<void> tapButton(WidgetTester tester, String label) async {
  await tester.tap(find.text(label));
  await tester.pump();
}
