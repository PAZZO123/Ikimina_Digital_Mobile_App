import 'package:intl/intl.dart';

class AppFormatters {
  AppFormatters._();

  // ─── Currency ───
  static final _rwf = NumberFormat('#,###', 'en_US');
  static final _compact = NumberFormat.compact(locale: 'en_US');

  static String rwf(double amount) => 'RWF ${_rwf.format(amount.round())}';

  static String compactRwf(double amount) {
    if (amount >= 1000000) {
      return 'RWF ${(amount / 1000000).toStringAsFixed(1)}M';
    }
    if (amount >= 1000) {
      return 'RWF ${(amount / 1000).toStringAsFixed(1)}K';
    }
    return rwf(amount);
  }

  static String percent(double value, {int decimals = 1}) =>
      '${(value * 100).toStringAsFixed(decimals)}%';

  // ─── Dates ───
  static final _short = DateFormat('d MMM yyyy');
  static final _long = DateFormat('EEEE, d MMMM yyyy');
  static final _time = DateFormat('HH:mm');
  static final _datetime = DateFormat('d MMM yyyy · HH:mm');
  static final _monthYear = DateFormat('MMMM yyyy');

  static String short(DateTime dt) => _short.format(dt);
  static String long(DateTime dt) => _long.format(dt);
  static String time(DateTime dt) => _time.format(dt);
  static String datetime(DateTime dt) => _datetime.format(dt);
  static String monthYear(DateTime dt) => _monthYear.format(dt);

  static String timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()}w ago';
    if (diff.inDays < 365) return '${(diff.inDays / 30).floor()}mo ago';
    return '${(diff.inDays / 365).floor()}y ago';
  }

  static String relativeDate(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(dt.year, dt.month, dt.day);
    final diff = date.difference(today).inDays;

    if (diff == 0) return 'Today';
    if (diff == 1) return 'Tomorrow';
    if (diff == -1) return 'Yesterday';
    if (diff > 1 && diff <= 7) return 'In $diff days';
    if (diff < -1 && diff >= -7) return '${-diff} days ago';
    return short(dt);
  }

  // ─── Names ───
  static String initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }

  static String firstName(String fullName) =>
      fullName.trim().split(RegExp(r'\s+')).first;

  // ─── Numbers ───
  static String ordinal(int n) {
    if (n >= 11 && n <= 13) return '${n}th';
    switch (n % 10) {
      case 1: return '${n}st';
      case 2: return '${n}nd';
      case 3: return '${n}rd';
      default: return '${n}th';
    }
  }

  static String contributionFrequencyLabel(String freq) {
    switch (freq) {
      case 'weekly': return 'Weekly';
      case 'biweekly': return 'Bi-weekly';
      case 'monthly': return 'Monthly';
      default: return freq;
    }
  }
}
