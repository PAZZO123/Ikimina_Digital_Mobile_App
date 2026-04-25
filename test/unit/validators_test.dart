import 'package:flutter_test/flutter_test.dart';
import 'package:ikimina_digital/core/utils/validators.dart';
import 'package:ikimina_digital/core/utils/formatters.dart';

void main() {
  // ─── Validators ───
  group('Validators', () {
    group('email', () {
      test('valid email passes', () {
        expect(Validators.email('user@example.com'), isNull);
        expect(Validators.email('test.user+tag@domain.co.rw'), isNull);
      });

      test('invalid email fails', () {
        expect(Validators.email(''), isNotNull);
        expect(Validators.email('notanemail'), isNotNull);
        expect(Validators.email('missing@'), isNotNull);
        expect(Validators.email('@nodomain.com'), isNotNull);
      });
    });

    group('password', () {
      test('valid password passes', () {
        expect(Validators.password('SecurePass1'), isNull);
        expect(Validators.password('MyPassword123'), isNull);
      });

      test('short password fails', () {
        expect(Validators.password('short'), isNotNull);
        expect(Validators.password('1234567'), isNotNull);
      });

      test('password without uppercase fails', () {
        expect(Validators.password('alllowercase1'), isNotNull);
      });

      test('password without number fails', () {
        expect(Validators.password('NoNumbersHere'), isNotNull);
      });

      test('empty password fails', () {
        expect(Validators.password(''), isNotNull);
        expect(Validators.password(null), isNotNull);
      });
    });

    group('amount', () {
      test('valid amounts pass', () {
        expect(Validators.amount('50000'), isNull);
        expect(Validators.amount('1000000'), isNull);
        expect(Validators.amount('500', min: 100), isNull);
      });

      test('zero or negative fails', () {
        expect(Validators.amount('0'), isNotNull);
        expect(Validators.amount('-100'), isNotNull);
      });

      test('below minimum fails', () {
        expect(Validators.amount('499', min: 500), isNotNull);
      });

      test('above maximum fails', () {
        expect(Validators.amount('1001', max: 1000), isNotNull);
      });

      test('empty fails', () {
        expect(Validators.amount(''), isNotNull);
        expect(Validators.amount(null), isNotNull);
      });
    });

    group('phone', () {
      test('valid phones pass', () {
        expect(Validators.phone('0781234567'), isNull);
        expect(Validators.phone('+250781234567'), isNull);
        expect(Validators.phone('250781234567'), isNull);
      });

      test('short phone fails', () {
        expect(Validators.phone('12345'), isNotNull);
        expect(Validators.phone(''), isNotNull);
      });
    });

    group('inviteCode', () {
      test('valid 6-char code passes', () {
        expect(Validators.inviteCode('ABC123'), isNull);
        expect(Validators.inviteCode('XYZ999'), isNull);
      });

      test('wrong length fails', () {
        expect(Validators.inviteCode('ABC12'), isNotNull);
        expect(Validators.inviteCode('ABC1234'), isNotNull);
      });

      test('empty fails', () {
        expect(Validators.inviteCode(''), isNotNull);
        expect(Validators.inviteCode(null), isNotNull);
      });
    });

    group('fullName', () {
      test('valid full name passes', () {
        expect(Validators.fullName('Patrick Mbabazi'), isNull);
        expect(Validators.fullName('Habayimana Vincent'), isNull);
      });

      test('single name fails', () {
        expect(Validators.fullName('Patrick'), isNotNull);
      });

      test('empty fails', () {
        expect(Validators.fullName(''), isNotNull);
        expect(Validators.fullName(null), isNotNull);
      });
    });
  });

  // ─── Formatters ───
  group('AppFormatters', () {
    group('rwf', () {
      test('formats with commas', () {
        expect(AppFormatters.rwf(50000), 'RWF 50,000');
        expect(AppFormatters.rwf(1000000), 'RWF 1,000,000');
        expect(AppFormatters.rwf(500), 'RWF 500');
      });

      test('rounds decimal amounts', () {
        expect(AppFormatters.rwf(50000.9), 'RWF 50,001');
        expect(AppFormatters.rwf(999.1), 'RWF 999');
      });
    });

    group('compactRwf', () {
      test('shows millions', () {
        expect(AppFormatters.compactRwf(1500000), 'RWF 1.5M');
        expect(AppFormatters.compactRwf(10000000), 'RWF 10.0M');
      });

      test('shows thousands', () {
        expect(AppFormatters.compactRwf(50000), 'RWF 50.0K');
        expect(AppFormatters.compactRwf(1500), 'RWF 1.5K');
      });

      test('shows exact for small amounts', () {
        expect(AppFormatters.compactRwf(500), 'RWF 500');
      });
    });

    group('initials', () {
      test('extracts two initials', () {
        expect(AppFormatters.initials('Patrick Mbabazi'), 'PM');
        expect(AppFormatters.initials('Habayimana Vincent'), 'HV');
      });

      test('handles single name', () {
        expect(AppFormatters.initials('Patrick'), 'P');
      });

      test('uses first and last for multi-word names', () {
        expect(AppFormatters.initials('Jean Claude Habimana'), 'JH');
      });
    });

    group('ordinal', () {
      test('correct suffixes', () {
        expect(AppFormatters.ordinal(1), '1st');
        expect(AppFormatters.ordinal(2), '2nd');
        expect(AppFormatters.ordinal(3), '3rd');
        expect(AppFormatters.ordinal(4), '4th');
        expect(AppFormatters.ordinal(11), '11th');
        expect(AppFormatters.ordinal(12), '12th');
        expect(AppFormatters.ordinal(13), '13th');
        expect(AppFormatters.ordinal(21), '21st');
        expect(AppFormatters.ordinal(22), '22nd');
      });
    });

    group('timeAgo', () {
      test('recent times', () {
        expect(AppFormatters.timeAgo(DateTime.now()), 'Just now');
        expect(
          AppFormatters.timeAgo(DateTime.now().subtract(const Duration(minutes: 30))),
          '30m ago',
        );
        expect(
          AppFormatters.timeAgo(DateTime.now().subtract(const Duration(hours: 5))),
          '5h ago',
        );
        expect(
          AppFormatters.timeAgo(DateTime.now().subtract(const Duration(days: 3))),
          '3d ago',
        );
      });
    });
  });
}
