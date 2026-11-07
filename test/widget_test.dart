
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:facebook/screens/home_screen.dart';

void main() {
  testWidgets('Home Screen test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );

    expect(find.text('Facebook'), findsOneWidget);
    expect(find.text('Welcome to Facebook!'), findsOneWidget);
  });
}
