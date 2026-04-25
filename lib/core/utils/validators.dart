class Validators {
  Validators._();

  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final regex = RegExp(r'^[\w\.\+\-]+@[\w\-]+\.\w{2,}$');
    if (!regex.hasMatch(value.trim())) return 'Enter a valid email address';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Include at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Include at least one number';
    }
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != original) return 'Passwords do not match';
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 9) return 'Enter a valid phone number';
    return null;
  }

  static String? amount(String? value, {double min = 0, double? max}) {
    if (value == null || value.isEmpty) return 'Amount is required';
    final num = double.tryParse(value.replaceAll(',', ''));
    if (num == null) return 'Enter a valid amount';
    if (num <= 0) return 'Amount must be greater than zero';
    if (num < min) return 'Minimum amount is RWF ${min.round()}';
    if (max != null && num > max) return 'Maximum amount is RWF ${max.round()}';
    return null;
  }

  static String? groupName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Group name is required';
    if (value.trim().length < 3) return 'Name must be at least 3 characters';
    if (value.trim().length > 50) return 'Name cannot exceed 50 characters';
    return null;
  }

  static String? inviteCode(String? value) {
    if (value == null || value.isEmpty) return 'Invite code is required';
    if (value.trim().length != 6) return 'Invite code must be 6 characters';
    if (!RegExp(r'^[A-Z0-9]+$').hasMatch(value.trim().toUpperCase())) {
      return 'Invalid invite code format';
    }
    return null;
  }

  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Full name is required';
    final parts = value.trim().split(RegExp(r'\s+'));
    if (parts.length < 2) return 'Enter both first and last name';
    if (parts.any((p) => p.length < 2)) return 'Each name must be at least 2 characters';
    return null;
  }

  static String? loanPurpose(String? value) {
    if (value == null || value.trim().isEmpty) return 'Loan purpose is required';
    if (value.trim().length < 10) return 'Describe the purpose in at least 10 characters';
    return null;
  }
}
