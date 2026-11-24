
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:facebook/screens/home_screen.dart';
import 'package:facebook/widgets/storybar.dart';

void main() {
  testWidgets('HomeScreen tampil dengan benar', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );

    expect(find.text('Facebook'), findsOneWidget);
    expect(find.byType(Storybar), findsOneWidget);
    expect(find.text('Your Feed Will Appear Here'), findsOneWidget);
  });
}