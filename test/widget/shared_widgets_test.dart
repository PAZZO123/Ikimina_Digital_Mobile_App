import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ikimina_digital/core/theme/app_theme.dart';
import 'package:ikimina_digital/shared/widgets/shared_widgets.dart';

Widget wrap(Widget child) => MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(body: child),
    );

void main() {
  group('StatCard', () {
    testWidgets('renders label and value', (tester) async {
      await tester.pumpWidget(wrap(
        const StatCard(
          label: 'Balance',
          value: 'RWF 50,000',
          icon: Icons.savings_rounded,
          color: AppColors.primary,
        ),
      ));
      expect(find.text('Balance'), findsOneWidget);
      expect(find.text('RWF 50,000'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(wrap(
        StatCard(
          label: 'Test',
          value: '42',
          icon: Icons.star,
          color: Colors.blue,
          onTap: () => tapped = true,
        ),
      ));
      await tester.tap(find.byType(StatCard));
      expect(tapped, isTrue);
    });
  });

  group('EmptyState', () {
    testWidgets('renders title and subtitle', (tester) async {
      await tester.pumpWidget(wrap(
        const EmptyState(
          icon: Icons.group_outlined,
          title: 'No Groups',
          subtitle: 'Create one to get started',
        ),
      ));
      expect(find.text('No Groups'), findsOneWidget);
      expect(find.text('Create one to get started'), findsOneWidget);
    });

    testWidgets('renders action widget when provided', (tester) async {
      await tester.pumpWidget(wrap(
        EmptyState(
          icon: Icons.group_outlined,
          title: 'No Groups',
          subtitle: 'Create one',
          action: ElevatedButton(
            onPressed: () {},
            child: const Text('Create Group'),
          ),
        ),
      ));
      expect(find.text('Create Group'), findsOneWidget);
    });
  });

  group('StatusBadge', () {
    testWidgets('renders completed status', (tester) async {
      await tester.pumpWidget(wrap(const StatusBadge('completed')));
      expect(find.text('COMPLETED'), findsOneWidget);
    });

    testWidgets('renders pending status', (tester) async {
      await tester.pumpWidget(wrap(const StatusBadge('pending')));
      expect(find.text('PENDING'), findsOneWidget);
    });

    testWidgets('renders rejected status', (tester) async {
      await tester.pumpWidget(wrap(const StatusBadge('rejected')));
      expect(find.text('REJECTED'), findsOneWidget);
    });
  });

  group('MemberAvatar', () {
    testWidgets('shows initials when no image', (tester) async {
      await tester.pumpWidget(wrap(
        const MemberAvatar(name: 'Patrick Mbabazi'),
      ));
      expect(find.text('PM'), findsOneWidget);
    });

    testWidgets('single name shows first letter', (tester) async {
      await tester.pumpWidget(wrap(
        const MemberAvatar(name: 'Patrick'),
      ));
      expect(find.text('P'), findsOneWidget);
    });
  });

  group('LabeledProgress', () {
    testWidgets('renders labels and progress', (tester) async {
      await tester.pumpWidget(wrap(
        const LabeledProgress(
          label: 'Repayment',
          progress: 0.6,
          leftLabel: 'Paid: 60,000',
          rightLabel: 'Total: 100,000',
        ),
      ));
      expect(find.text('Repayment'), findsOneWidget);
      expect(find.text('60%'), findsOneWidget);
      expect(find.text('Paid: 60,000'), findsOneWidget);
      expect(find.text('Total: 100,000'), findsOneWidget);
    });

    testWidgets('clamps progress above 100%', (tester) async {
      await tester.pumpWidget(wrap(
        const LabeledProgress(
          label: 'Overdue',
          progress: 1.5,
          leftLabel: '',
          rightLabel: '',
        ),
      ));
      // Should not throw — LinearProgressIndicator clamps internally
      expect(find.byType(LabeledProgress), findsOneWidget);
    });
  });

  group('formatRWF', () {
    test('formats without decimals', () {
      expect(formatRWF(50000), 'RWF 50,000');
      expect(formatRWF(1000000), 'RWF 1,000,000');
      expect(formatRWF(500), 'RWF 500');
    });

    test('rounds fractional amounts', () {
      expect(formatRWF(999.9), 'RWF 1,000');
      expect(formatRWF(0.4), 'RWF 0');
    });
  });

  group('formatCompact', () {
    test('shows M for millions', () {
      expect(formatCompact(2000000), 'RWF 2.0M');
    });

    test('shows K for thousands', () {
      expect(formatCompact(75000), 'RWF 75.0K');
    });

    test('shows exact for small', () {
      expect(formatCompact(800), 'RWF 800');
    });
  });
}
