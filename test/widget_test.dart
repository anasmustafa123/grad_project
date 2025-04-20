// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:secndversion_of_gradproj/app.dart';

void main() {
  testWidgets('Login screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the login screen is displayed
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2)); // Email and password fields
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Forgot Password?'), findsOneWidget);

    // Test email field
    await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
    expect(find.text('test@example.com'), findsOneWidget);

    // Test password field
    await tester.enterText(find.byType(TextFormField).last, 'password123');
    expect(find.text('password123'), findsOneWidget);

    // Test password visibility toggle
    await tester.tap(find.byIcon(Icons.visibility));
    await tester.pump();
    expect(find.text('password123'), findsOneWidget);
  });
}
