class AppConstants {
  // App Info
  static const String appName = 'Ikimina Digital';
  static const String appVersion = '1.0.0';

  // Firestore Collections
  static const String usersCollection = 'users';
  static const String groupsCollection = 'groups';
  static const String contributionsCollection = 'contributions';
  static const String loansCollection = 'loans';
  static const String payoutsCollection = 'payouts';
  static const String finesCollection = 'fines';
  static const String notificationsCollection = 'notifications';
  static const String invitationsCollection = 'invitations';
  static const String joinRequestsCollection = 'joinRequests';
  static const String groupBroadcastsCollection = 'groupBroadcasts';
  static const String contributionRequestsCollection = 'contributionRequests';
  static const String repaymentRequestsCollection = 'repaymentRequests';

  // Shared Preferences Keys
  static const String prefUserId = 'user_id';
  static const String prefUserRole = 'user_role';
  static const String prefLanguage = 'language';
  static const String prefBiometric = 'biometric_enabled';
  static const String prefOnboarded = 'onboarded';
  static const String prefTheme = 'theme_mode';

  // Roles
  static const String roleAdmin = 'admin';
  static const String roleMember = 'member';

  // Status
  static const String statusPending = 'pending';
  static const String statusApproved = 'approved';
  static const String statusRejected = 'rejected';
  static const String statusCompleted = 'completed';
  static const String statusActive = 'active';
  static const String statusInactive = 'inactive';
  static const String statusOverdue = 'overdue';

  // Contribution Frequencies
  static const String freqWeekly = 'weekly';
  static const String freqBiweekly = 'biweekly';
  static const String freqMonthly = 'monthly';

  // Pagination
  static const int pageSize = 20;

  // Validation
  static const int minGroupSize = 2;
  static const int maxGroupSize = 50;
  static const double minContribution = 500; // RWF
  static const double maxContribution = 10000000; // RWF
  static const double maxLoanMultiplier = 3.0;

  // Rwanda currency
  static const String currency = 'RWF';
  static const String currencySymbol = 'RWF';

  // Animation durations
  static const Duration animShort = Duration(milliseconds: 200);
  static const Duration animMedium = Duration(milliseconds: 350);
  static const Duration animLong = Duration(milliseconds: 500);
}

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String verifyEmail = '/verify-email';
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  static const String groups = '/groups';
  static const String groupDetail = '/groups/:groupId';
  static const String createGroup = '/groups/create';
  static const String groupMembers = '/groups/:groupId/members';
  static const String contributions = '/contributions';
  static const String addContribution = '/contributions/add';
  static const String loans = '/loans';
  static const String loanDetail = '/loans/:loanId';
  static const String requestLoan = '/loans/request';
  static const String payouts = '/payouts';
  static const String reports = '/reports';
  static const String notifications = '/notifications';
  static const String profile = '/profile';
  static const String settings = '/settings';
}
