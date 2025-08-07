import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Navigation drawer contains all sections', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Open the drawer using the hamburger icon.
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsWidgets); // app bar + drawer item
    expect(find.text('Chatbot'), findsOneWidget);
    expect(find.text('API 2'), findsOneWidget);
    expect(find.text('API 3'), findsOneWidget);
  });
}

