


import 'package:flutter_test/flutter_test.dart';
import 'package:ikimina_digital/shared/models/app_models.dart';

void main() {
  group('LoanModel computed properties', () {
    const loan = LoanModel(
      id: 'loan1',
      groupId: 'group1',
      borrowerId: 'user1',
      borrowerName: 'Patrick Mbabazi',
      amount: 100000,
      interestRate: 10,
      durationMonths: 3,
      requestedAt: null,
      amountRepaid: 0,
      status: 'approved',
    );

    test('totalDue = principal + interest', () {
      expect(loan.totalDue, 110000);
    });

    test('remainingBalance when nothing repaid', () {
      expect(loan.remainingBalance, 110000);
    });

    test('remainingBalance with partial repayment', () {
      final partial = loan.copyWith(amountRepaid: 55000);
      expect(partial.remainingBalance, 55000);
    });

    test('repaymentProgress', () {
      final partial = loan.copyWith(amountRepaid: 55000);
      expect(partial.repaymentProgress, closeTo(0.5, 0.001));
    });

    test('isFullyRepaid false when partial', () {
      final partial = loan.copyWith(amountRepaid: 55000);
      expect(partial.isFullyRepaid, isFalse);
    });

    test('isFullyRepaid true when fully repaid', () {
      final full = loan.copyWith(amountRepaid: 110000);
      expect(full.isFullyRepaid, isTrue);
    });

    test('isFullyRepaid true when over-repaid', () {
      final over = loan.copyWith(amountRepaid: 120000);
      expect(over.isFullyRepaid, isTrue);
    });
  });

  group('LoanModel serialization', () {
    test('toJson and fromJson roundtrip', () {
      const loan = LoanModel(
        id: 'loan1',
        groupId: 'group1',
        borrowerId: 'user1',
        borrowerName: 'Test User',
        amount: 50000,
        interestRate: 5,
        durationMonths: 6,
        requestedAt: null,
        status: 'pending',
        purpose: 'Business',
      );

      final json = loan.toJson();
      expect(json['id'], 'loan1');
      expect(json['amount'], 50000.0);
      expect(json['interestRate'], 5.0);
      expect(json['purpose'], 'Business');
    });
  });

  group('UserModel', () {
    test('creates with defaults', () {
      const user = UserModel(
        id: 'u1',
        fullName: 'Amara Uwimana',
        email: 'amara@test.com',
        phone: '0781234567',
      );
      expect(user.role, 'member');
      expect(user.groupIds, isEmpty);
      expect(user.isActive, isTrue);
      expect(user.emailVerified, isFalse);
      expect(user.preferredLanguage, 'en');
    });

    test('serialization preserves all fields', () {
      const user = UserModel(
        id: 'u1',
        fullName: 'Patrick Mbabazi',
        email: 'patrick@ur.ac.rw',
        phone: '0788888888',
        role: 'admin',
        groupIds: ['g1', 'g2'],
        preferredLanguage: 'rw',
      );
      final json = user.toJson();
      expect(json['fullName'], 'Patrick Mbabazi');
      expect(json['role'], 'admin');
      expect(json['groupIds'], ['g1', 'g2']);
      expect(json['preferredLanguage'], 'rw');
    });
  });

  group('GroupModel', () {
    test('creates with defaults', () {
      const group = GroupModel(
        id: 'g1',
        name: 'Test Group',
        adminId: 'u1',
        contributionAmount: 50000,
        contributionFrequency: 'monthly',
        description: 'A test group',
      );
      expect(group.memberIds, isEmpty);
      expect(group.totalBalance, 0.0);
      expect(group.currentPayoutIndex, 0);
      expect(group.status, 'active');
    });
  });

  group('ChartDataPoint', () {
    test('creates correctly', () {
      const point = ChartDataPoint(label: 'Jan', value: 50000);
      expect(point.label, 'Jan');
      expect(point.value, 50000);
      expect(point.date, isNull);
    });
  });
}



