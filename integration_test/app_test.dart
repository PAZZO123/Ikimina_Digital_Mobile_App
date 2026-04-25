import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ikimina_digital/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Ikimina Digital Integration Tests', () {
    testWidgets('App launches and shows splash screen', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: IkiminaApp()));
      await tester.pump(const Duration(milliseconds: 500));

      // Splash screen should be visible
      expect(find.text('Ikimina Digital'), findsOneWidget);
    });

    testWidgets('Navigates to login after splash', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: IkiminaApp()));
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Should land on login or onboarding
      expect(
        find.byType(TextFormField),
        findsWidgets,
      );
    });
  });
}
