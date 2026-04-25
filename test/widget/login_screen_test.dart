import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ikimina_digital/core/theme/app_theme.dart';
import 'package:ikimina_digital/features/auth/presentation/screens/login_screen.dart';

Widget buildTestApp(Widget child) {
  return ProviderScope(
    child: MaterialApp(
      theme: AppTheme.lightTheme,
      home: child,
    ),
  );
}

void main() {
  group('LoginScreen Widget Tests', () {
    testWidgets('Shows email and password fields', (tester) async {
      await tester.pumpWidget(buildTestApp(const LoginScreen()));
      await tester.pump();

      expect(find.text('Welcome back'), findsOneWidget);
      expect(find.text('Email address'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
    });

    testWidgets('Shows validation error when submitting empty form', (tester) async {
      await tester.pumpWidget(buildTestApp(const LoginScreen()));
      await tester.pump();

      // Tap sign in without filling fields
      await tester.tap(find.text('Sign In'));
      await tester.pump();

      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);
    });

    testWidgets('Shows invalid email error', (tester) async {
      await tester.pumpWidget(buildTestApp(const LoginScreen()));
      await tester.pump();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email address'),
        'notanemail',
      );
      await tester.tap(find.text('Sign In'));
      await tester.pump();

      expect(find.text('Enter a valid email'), findsOneWidget);
    });

    testWidgets('Shows link to register screen', (tester) async {
      await tester.pumpWidget(buildTestApp(const LoginScreen()));
      await tester.pump();

      expect(find.text('Create account'), findsOneWidget);
    });

    testWidgets('Shows forgot password link', (tester) async {
      await tester.pumpWidget(buildTestApp(const LoginScreen()));
      await tester.pump();

      expect(find.text('Forgot password?'), findsOneWidget);
    });

    testWidgets('Password visibility toggle works', (tester) async {
      await tester.pumpWidget(buildTestApp(const LoginScreen()));
      await tester.pump();

      // Find the visibility toggle icon
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);

      await tester.tap(find.byIcon(Icons.visibility_off_outlined));
      await tester.pump();

      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    });
  });
}
