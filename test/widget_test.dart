
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('KosFinder app starts', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Text('KosFinder'),
        ),
      ),
    );

    expect(find.text('KosFinder'), findsOneWidget);
  });
}
