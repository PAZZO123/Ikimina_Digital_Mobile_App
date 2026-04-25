import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_rw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
    Locale('rw')
  ];

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'Ikimina Digital'**
  String get appName;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcome;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phone;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @groups.
  ///
  /// In en, this message translates to:
  /// **'Groups'**
  String get groups;

  /// No description provided for @loans.
  ///
  /// In en, this message translates to:
  /// **'Loans'**
  String get loans;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @myGroups.
  ///
  /// In en, this message translates to:
  /// **'My Groups'**
  String get myGroups;

  /// No description provided for @createGroup.
  ///
  /// In en, this message translates to:
  /// **'Create Group'**
  String get createGroup;

  /// No description provided for @joinGroup.
  ///
  /// In en, this message translates to:
  /// **'Join Group'**
  String get joinGroup;

  /// No description provided for @groupName.
  ///
  /// In en, this message translates to:
  /// **'Group Name'**
  String get groupName;

  /// No description provided for @groupDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get groupDescription;

  /// No description provided for @contributionAmount.
  ///
  /// In en, this message translates to:
  /// **'Contribution Amount'**
  String get contributionAmount;

  /// No description provided for @contributionFrequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get contributionFrequency;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @inviteCode.
  ///
  /// In en, this message translates to:
  /// **'Invite Code'**
  String get inviteCode;

  /// No description provided for @members.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get members;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @biweekly.
  ///
  /// In en, this message translates to:
  /// **'Bi-weekly'**
  String get biweekly;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @totalBalance.
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get totalBalance;

  /// No description provided for @totalContributed.
  ///
  /// In en, this message translates to:
  /// **'Total Contributed'**
  String get totalContributed;

  /// No description provided for @totalLoaned.
  ///
  /// In en, this message translates to:
  /// **'Total Loaned'**
  String get totalLoaned;

  /// No description provided for @recordContribution.
  ///
  /// In en, this message translates to:
  /// **'Record Contribution'**
  String get recordContribution;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @requestLoan.
  ///
  /// In en, this message translates to:
  /// **'Request Loan'**
  String get requestLoan;

  /// No description provided for @loanAmount.
  ///
  /// In en, this message translates to:
  /// **'Loan Amount'**
  String get loanAmount;

  /// No description provided for @purpose.
  ///
  /// In en, this message translates to:
  /// **'Purpose'**
  String get purpose;

  /// No description provided for @interestRate.
  ///
  /// In en, this message translates to:
  /// **'Interest Rate'**
  String get interestRate;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @generateReport.
  ///
  /// In en, this message translates to:
  /// **'Generate Report'**
  String get generateReport;

  /// No description provided for @shareReport.
  ///
  /// In en, this message translates to:
  /// **'Share Report'**
  String get shareReport;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @noGroups.
  ///
  /// In en, this message translates to:
  /// **'No Groups Yet'**
  String get noGroups;

  /// No description provided for @noLoans.
  ///
  /// In en, this message translates to:
  /// **'No Loans'**
  String get noLoans;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No Notifications'**
  String get noNotifications;

  /// No description provided for @noContributions.
  ///
  /// In en, this message translates to:
  /// **'No Contributions'**
  String get noContributions;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @errorRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get errorRequired;

  /// No description provided for @errorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get errorInvalidEmail;

  /// No description provided for @errorPasswordShort.
  ///
  /// In en, this message translates to:
  /// **'Min 8 characters'**
  String get errorPasswordShort;

  /// No description provided for @errorPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get errorPasswordMismatch;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'RWF'**
  String get currency;

  /// No description provided for @payoutCycle.
  ///
  /// In en, this message translates to:
  /// **'Payout Cycle'**
  String get payoutCycle;

  /// No description provided for @nextContribution.
  ///
  /// In en, this message translates to:
  /// **'Next Contribution'**
  String get nextContribution;

  /// No description provided for @payoutPosition.
  ///
  /// In en, this message translates to:
  /// **'Payout Position'**
  String get payoutPosition;

  /// No description provided for @signInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to manage your savings groups'**
  String get signInSubtitle;

  /// No description provided for @accountInfo.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get accountInfo;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// No description provided for @biometricLogin.
  ///
  /// In en, this message translates to:
  /// **'Biometric Login'**
  String get biometricLogin;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @contribute.
  ///
  /// In en, this message translates to:
  /// **'Contribute'**
  String get contribute;

  /// No description provided for @newGroup.
  ///
  /// In en, this message translates to:
  /// **'New Group'**
  String get newGroup;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @contribution.
  ///
  /// In en, this message translates to:
  /// **'Contribution'**
  String get contribution;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @joinWithCode.
  ///
  /// In en, this message translates to:
  /// **'Join with Code'**
  String get joinWithCode;

  /// No description provided for @noAccountYet.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccountYet;

  /// No description provided for @memberId.
  ///
  /// In en, this message translates to:
  /// **'Member ID'**
  String get memberId;

  /// No description provided for @loanOverview.
  ///
  /// In en, this message translates to:
  /// **'Loan Overview'**
  String get loanOverview;

  /// No description provided for @totalLoanedOut.
  ///
  /// In en, this message translates to:
  /// **'Total Loaned Out'**
  String get totalLoanedOut;

  /// No description provided for @availableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get availableBalance;

  /// No description provided for @needLoan.
  ///
  /// In en, this message translates to:
  /// **'Need a loan?'**
  String get needLoan;

  /// No description provided for @borrowFromGroup.
  ///
  /// In en, this message translates to:
  /// **'Borrow from your group\'s savings'**
  String get borrowFromGroup;

  /// No description provided for @recentLoans.
  ///
  /// In en, this message translates to:
  /// **'Recent Loans'**
  String get recentLoans;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join Ikimina Digital and manage your savings'**
  String get registerSubtitle;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @signInLink.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInLink;

  /// No description provided for @iAgreeToThe.
  ///
  /// In en, this message translates to:
  /// **'I agree to the '**
  String get iAgreeToThe;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @andWord.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get andWord;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @acceptTermsError.
  ///
  /// In en, this message translates to:
  /// **'Please accept the terms and conditions'**
  String get acceptTermsError;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameRequired;

  /// No description provided for @enterFirstLastName.
  ///
  /// In en, this message translates to:
  /// **'Enter first and last name'**
  String get enterFirstLastName;

  /// No description provided for @phoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone is required'**
  String get phoneRequired;

  /// No description provided for @enterValidPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get enterValidPhone;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @resetPasswordInstructions.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we\'ll send you a link to reset your password.'**
  String get resetPasswordInstructions;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @checkYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get checkYourEmail;

  /// No description provided for @backToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Back to Sign In'**
  String get backToSignIn;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @continueBtnLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueBtnLabel;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Create Your Ikimina'**
  String get onboardingTitle1;

  /// No description provided for @onboardingSubtitle1.
  ///
  /// In en, this message translates to:
  /// **'Start or join a digital savings group with family, friends, or colleagues.'**
  String get onboardingSubtitle1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Track Every Franc'**
  String get onboardingTitle2;

  /// No description provided for @onboardingSubtitle2.
  ///
  /// In en, this message translates to:
  /// **'Record contributions, monitor balances, and view financial history in real time.'**
  String get onboardingSubtitle2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Transparent Payouts'**
  String get onboardingTitle3;

  /// No description provided for @onboardingSubtitle3.
  ///
  /// In en, this message translates to:
  /// **'Automated rotation scheduling ensures everyone gets their turn fairly.'**
  String get onboardingSubtitle3;

  /// No description provided for @onboardingTitle4.
  ///
  /// In en, this message translates to:
  /// **'Instant Reports'**
  String get onboardingTitle4;

  /// No description provided for @onboardingSubtitle4.
  ///
  /// In en, this message translates to:
  /// **'Download professional PDF financial reports for full accountability.'**
  String get onboardingSubtitle4;

  /// No description provided for @loadingDashboard.
  ///
  /// In en, this message translates to:
  /// **'Loading dashboard...'**
  String get loadingDashboard;

  /// No description provided for @totalBalanceAllGroups.
  ///
  /// In en, this message translates to:
  /// **'Total Balance Across All Groups'**
  String get totalBalanceAllGroups;

  /// No description provided for @activeGroups.
  ///
  /// In en, this message translates to:
  /// **'Active Groups'**
  String get activeGroups;

  /// No description provided for @groupBalanceOverview.
  ///
  /// In en, this message translates to:
  /// **'Group Balance Overview'**
  String get groupBalanceOverview;

  /// No description provided for @allGroupsLabel.
  ///
  /// In en, this message translates to:
  /// **'All groups'**
  String get allGroupsLabel;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noData;

  /// No description provided for @completeYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete Your Profile'**
  String get completeYourProfile;

  /// No description provided for @completeProfileInstructions.
  ///
  /// In en, this message translates to:
  /// **'Please fill in your details to complete your account setup.'**
  String get completeProfileInstructions;

  /// No description provided for @loadingGroups.
  ///
  /// In en, this message translates to:
  /// **'Loading groups...'**
  String get loadingGroups;

  /// No description provided for @joinAGroup.
  ///
  /// In en, this message translates to:
  /// **'Join a Group'**
  String get joinAGroup;

  /// No description provided for @joinGroupInstructions.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-character invite code shared by the group admin.'**
  String get joinGroupInstructions;

  /// No description provided for @enterValidCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter a 6-character invite code.'**
  String get enterValidCode;

  /// No description provided for @requestSentWaiting.
  ///
  /// In en, this message translates to:
  /// **'Request sent! Waiting for admin approval.'**
  String get requestSentWaiting;

  /// No description provided for @sendRequest.
  ///
  /// In en, this message translates to:
  /// **'Send Request'**
  String get sendRequest;

  /// No description provided for @payoutCycleProgress.
  ///
  /// In en, this message translates to:
  /// **'Payout Cycle Progress'**
  String get payoutCycleProgress;

  /// No description provided for @groupNotFound.
  ///
  /// In en, this message translates to:
  /// **'Group not found'**
  String get groupNotFound;

  /// No description provided for @joinRequests.
  ///
  /// In en, this message translates to:
  /// **'Join Requests'**
  String get joinRequests;

  /// No description provided for @processPayout.
  ///
  /// In en, this message translates to:
  /// **'Process Payout'**
  String get processPayout;

  /// No description provided for @issueFine.
  ///
  /// In en, this message translates to:
  /// **'Issue Fine'**
  String get issueFine;

  /// No description provided for @shareInviteCode.
  ///
  /// In en, this message translates to:
  /// **'Share Invite Code'**
  String get shareInviteCode;

  /// No description provided for @tabOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get tabOverview;

  /// No description provided for @tabContribute.
  ///
  /// In en, this message translates to:
  /// **'Contribute'**
  String get tabContribute;

  /// No description provided for @tabPayouts.
  ///
  /// In en, this message translates to:
  /// **'Payouts'**
  String get tabPayouts;

  /// No description provided for @processPayoutQuestion.
  ///
  /// In en, this message translates to:
  /// **'Process Payout?'**
  String get processPayoutQuestion;

  /// No description provided for @contributed.
  ///
  /// In en, this message translates to:
  /// **'Contributed'**
  String get contributed;

  /// No description provided for @loanedOut.
  ///
  /// In en, this message translates to:
  /// **'Loaned Out'**
  String get loanedOut;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @perContribution.
  ///
  /// In en, this message translates to:
  /// **'Per Contribution'**
  String get perContribution;

  /// No description provided for @viewAllMembers.
  ///
  /// In en, this message translates to:
  /// **'View All Members'**
  String get viewAllMembers;

  /// No description provided for @noContributionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Contributions will appear here once recorded.'**
  String get noContributionsSubtitle;

  /// No description provided for @recordLabel.
  ///
  /// In en, this message translates to:
  /// **'Record'**
  String get recordLabel;

  /// No description provided for @noLoansYet.
  ///
  /// In en, this message translates to:
  /// **'No Loans Yet'**
  String get noLoansYet;

  /// No description provided for @noLoansSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Any member can request a loan. Admin approves or rejects it.'**
  String get noLoansSubtitle;

  /// No description provided for @you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// No description provided for @noPurpose.
  ///
  /// In en, this message translates to:
  /// **'No purpose stated'**
  String get noPurpose;

  /// No description provided for @adminAction.
  ///
  /// In en, this message translates to:
  /// **'Admin action:'**
  String get adminAction;

  /// No description provided for @awaitingApproval.
  ///
  /// In en, this message translates to:
  /// **'Awaiting admin approval'**
  String get awaitingApproval;

  /// No description provided for @payoutRotation.
  ///
  /// In en, this message translates to:
  /// **'Payout Rotation'**
  String get payoutRotation;

  /// No description provided for @nextLabel.
  ///
  /// In en, this message translates to:
  /// **'NEXT'**
  String get nextLabel;

  /// No description provided for @paidLabel.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paidLabel;

  /// No description provided for @noPendingRequests.
  ///
  /// In en, this message translates to:
  /// **'No pending join requests'**
  String get noPendingRequests;

  /// No description provided for @copyCode.
  ///
  /// In en, this message translates to:
  /// **'Copy Code'**
  String get copyCode;

  /// No description provided for @copyMessage.
  ///
  /// In en, this message translates to:
  /// **'Copy Message'**
  String get copyMessage;

  /// No description provided for @inviteCodeCopied.
  ///
  /// In en, this message translates to:
  /// **'Invite code copied!'**
  String get inviteCodeCopied;

  /// No description provided for @inviteMessageCopied.
  ///
  /// In en, this message translates to:
  /// **'Invite message copied! Paste it in WhatsApp or SMS.'**
  String get inviteMessageCopied;

  /// No description provided for @codeCopied.
  ///
  /// In en, this message translates to:
  /// **'Code copied!'**
  String get codeCopied;

  /// No description provided for @payoutProcessed.
  ///
  /// In en, this message translates to:
  /// **'Payout processed successfully!'**
  String get payoutProcessed;

  /// No description provided for @createNewGroup.
  ///
  /// In en, this message translates to:
  /// **'Create New Group'**
  String get createNewGroup;

  /// No description provided for @groupDetails.
  ///
  /// In en, this message translates to:
  /// **'Group Details'**
  String get groupDetails;

  /// No description provided for @contributionRules.
  ///
  /// In en, this message translates to:
  /// **'Contribution Rules'**
  String get contributionRules;

  /// No description provided for @summaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summaryLabel;

  /// No description provided for @createGroupAdminNote.
  ///
  /// In en, this message translates to:
  /// **'You will be the admin of this group. An invite code will be generated automatically.'**
  String get createGroupAdminNote;

  /// No description provided for @allocation.
  ///
  /// In en, this message translates to:
  /// **'Allocation'**
  String get allocation;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @loanedOutLabel.
  ///
  /// In en, this message translates to:
  /// **'Loaned out'**
  String get loanedOutLabel;

  /// No description provided for @requestLabel.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get requestLabel;

  /// No description provided for @joinGroupForLoans.
  ///
  /// In en, this message translates to:
  /// **'Join or create a group to access loan features.'**
  String get joinGroupForLoans;

  /// No description provided for @requestALoan.
  ///
  /// In en, this message translates to:
  /// **'Request a Loan'**
  String get requestALoan;

  /// No description provided for @purposeOfLoan.
  ///
  /// In en, this message translates to:
  /// **'Purpose of Loan'**
  String get purposeOfLoan;

  /// No description provided for @repaymentSummary.
  ///
  /// In en, this message translates to:
  /// **'Repayment Summary'**
  String get repaymentSummary;

  /// No description provided for @principal.
  ///
  /// In en, this message translates to:
  /// **'Principal'**
  String get principal;

  /// No description provided for @totalToRepay.
  ///
  /// In en, this message translates to:
  /// **'Total to Repay'**
  String get totalToRepay;

  /// No description provided for @monthlyPayment.
  ///
  /// In en, this message translates to:
  /// **'Monthly Payment'**
  String get monthlyPayment;

  /// No description provided for @submitLoanRequest.
  ///
  /// In en, this message translates to:
  /// **'Submit Loan Request'**
  String get submitLoanRequest;

  /// No description provided for @loanDetails.
  ///
  /// In en, this message translates to:
  /// **'Loan Details'**
  String get loanDetails;

  /// No description provided for @borrower.
  ///
  /// In en, this message translates to:
  /// **'Borrower'**
  String get borrower;

  /// No description provided for @statusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get statusLabel;

  /// No description provided for @dueDate.
  ///
  /// In en, this message translates to:
  /// **'Due Date'**
  String get dueDate;

  /// No description provided for @makeRepayment.
  ///
  /// In en, this message translates to:
  /// **'Make Repayment'**
  String get makeRepayment;

  /// No description provided for @repaymentRecorded.
  ///
  /// In en, this message translates to:
  /// **'Repayment recorded successfully!'**
  String get repaymentRecorded;

  /// No description provided for @loanRequestSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Loan request submitted!'**
  String get loanRequestSubmitted;

  /// No description provided for @amountRWF.
  ///
  /// In en, this message translates to:
  /// **'Amount (RWF)'**
  String get amountRWF;

  /// No description provided for @loanAmountRWF.
  ///
  /// In en, this message translates to:
  /// **'Loan Amount (RWF)'**
  String get loanAmountRWF;

  /// No description provided for @contributionAmountRWF.
  ///
  /// In en, this message translates to:
  /// **'Contribution Amount (RWF)'**
  String get contributionAmountRWF;

  /// No description provided for @notesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get notesOptional;

  /// No description provided for @amountRequired.
  ///
  /// In en, this message translates to:
  /// **'Amount is required'**
  String get amountRequired;

  /// No description provided for @enterValidAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid amount'**
  String get enterValidAmount;

  /// No description provided for @descriptionRequired.
  ///
  /// In en, this message translates to:
  /// **'Description is required'**
  String get descriptionRequired;

  /// No description provided for @markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get markAllRead;

  /// No description provided for @allCaughtUp.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up!'**
  String get allCaughtUp;

  /// No description provided for @financialReports.
  ///
  /// In en, this message translates to:
  /// **'Financial Reports'**
  String get financialReports;

  /// No description provided for @noReports.
  ///
  /// In en, this message translates to:
  /// **'No Reports Available'**
  String get noReports;

  /// No description provided for @noReportsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join or create a group to generate financial reports.'**
  String get noReportsSubtitle;

  /// No description provided for @pdfReports.
  ///
  /// In en, this message translates to:
  /// **'PDF Reports'**
  String get pdfReports;

  /// No description provided for @pdfReportsDescription.
  ///
  /// In en, this message translates to:
  /// **'Generate comprehensive financial statements for transparency and auditing.'**
  String get pdfReportsDescription;

  /// No description provided for @generating.
  ///
  /// In en, this message translates to:
  /// **'Generating...'**
  String get generating;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @sharePDF.
  ///
  /// In en, this message translates to:
  /// **'Share PDF'**
  String get sharePDF;

  /// No description provided for @recordContributionTitle.
  ///
  /// In en, this message translates to:
  /// **'Record Contribution'**
  String get recordContributionTitle;

  /// No description provided for @groupMembersTitle.
  ///
  /// In en, this message translates to:
  /// **'Group Members'**
  String get groupMembersTitle;

  /// No description provided for @recordingFor.
  ///
  /// In en, this message translates to:
  /// **'Recording for'**
  String get recordingFor;

  /// No description provided for @selectGroup.
  ///
  /// In en, this message translates to:
  /// **'Select a group'**
  String get selectGroup;

  /// No description provided for @payoutPositionLabel.
  ///
  /// In en, this message translates to:
  /// **'Payout position: #{pos}'**
  String payoutPositionLabel(int pos);

  /// No description provided for @resetLinkSentTo.
  ///
  /// In en, this message translates to:
  /// **'We sent a reset link to {email}'**
  String resetLinkSentTo(String email);

  /// No description provided for @interestRateValue.
  ///
  /// In en, this message translates to:
  /// **'Interest Rate: {rate}%'**
  String interestRateValue(String rate);

  /// No description provided for @repaymentDurationValue.
  ///
  /// In en, this message translates to:
  /// **'Repayment Duration: {months} months'**
  String repaymentDurationValue(int months);

  /// No description provided for @interestWithRate.
  ///
  /// In en, this message translates to:
  /// **'Interest ({rate}%)'**
  String interestWithRate(String rate);

  /// No description provided for @remainingAmount.
  ///
  /// In en, this message translates to:
  /// **'Remaining: {amount}'**
  String remainingAmount(String amount);

  /// No description provided for @pendingJoinRequests.
  ///
  /// In en, this message translates to:
  /// **'{count} Pending Join Request'**
  String pendingJoinRequests(int count);

  /// No description provided for @roundNumber.
  ///
  /// In en, this message translates to:
  /// **'Round {number}'**
  String roundNumber(int number);

  /// No description provided for @loanRules.
  ///
  /// In en, this message translates to:
  /// **'Loan Rules'**
  String get loanRules;

  /// No description provided for @loanRulesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'These rules govern how members can borrow from this group.'**
  String get loanRulesSubtitle;

  /// No description provided for @defaultInterestRate.
  ///
  /// In en, this message translates to:
  /// **'Default Interest (%)'**
  String get defaultInterestRate;

  /// No description provided for @maxRepaymentMonths.
  ///
  /// In en, this message translates to:
  /// **'Max Repayment (months)'**
  String get maxRepaymentMonths;

  /// No description provided for @loanPenaltyRate.
  ///
  /// In en, this message translates to:
  /// **'Late Penalty (%)'**
  String get loanPenaltyRate;

  /// No description provided for @penaltyGraceDays.
  ///
  /// In en, this message translates to:
  /// **'Grace Period (days)'**
  String get penaltyGraceDays;

  /// No description provided for @maxLoanMultiplier.
  ///
  /// In en, this message translates to:
  /// **'Max Loan (× savings)'**
  String get maxLoanMultiplier;

  /// No description provided for @minContributions.
  ///
  /// In en, this message translates to:
  /// **'Min Contributions'**
  String get minContributions;

  /// No description provided for @yourSavingsInGroup.
  ///
  /// In en, this message translates to:
  /// **'Your savings in this group'**
  String get yourSavingsInGroup;

  /// No description provided for @yourBorrowingLimit.
  ///
  /// In en, this message translates to:
  /// **'Your borrowing limit'**
  String get yourBorrowingLimit;

  /// No description provided for @interestRateSetByGroup.
  ///
  /// In en, this message translates to:
  /// **'Interest rate is fixed by the group admin.'**
  String get interestRateSetByGroup;

  /// No description provided for @overdue.
  ///
  /// In en, this message translates to:
  /// **'OVERDUE'**
  String get overdue;

  /// No description provided for @selectMember.
  ///
  /// In en, this message translates to:
  /// **'Select Member'**
  String get selectMember;

  /// No description provided for @contributionRecorded.
  ///
  /// In en, this message translates to:
  /// **'Contribution recorded successfully!'**
  String get contributionRecorded;

  /// No description provided for @loanInsufficientBalance.
  ///
  /// In en, this message translates to:
  /// **'Group balance is insufficient for this loan.'**
  String get loanInsufficientBalance;

  /// No description provided for @loanEligibilityContributions.
  ///
  /// In en, this message translates to:
  /// **'You need at least {min} contribution(s) to be eligible.'**
  String loanEligibilityContributions(int min);

  /// No description provided for @loanEligibilityLimit.
  ///
  /// In en, this message translates to:
  /// **'Amount exceeds your borrowing limit of {limit}.'**
  String loanEligibilityLimit(String limit);

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @sendAnnouncement.
  ///
  /// In en, this message translates to:
  /// **'Send Announcement'**
  String get sendAnnouncement;

  /// No description provided for @announcements.
  ///
  /// In en, this message translates to:
  /// **'Announcements'**
  String get announcements;

  /// No description provided for @announcementTitle.
  ///
  /// In en, this message translates to:
  /// **'Announcement Title'**
  String get announcementTitle;

  /// No description provided for @announcementMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get announcementMessage;

  /// No description provided for @announcementHint.
  ///
  /// In en, this message translates to:
  /// **'Write a message to all group members...'**
  String get announcementHint;

  /// No description provided for @reactionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reactions'**
  String get reactionsTitle;

  /// No description provided for @noAnnouncements.
  ///
  /// In en, this message translates to:
  /// **'No announcements yet'**
  String get noAnnouncements;

  /// No description provided for @noAnnouncementsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'As admin, you can send announcements to all members.'**
  String get noAnnouncementsSubtitle;

  /// No description provided for @sendAnnouncementSuccess.
  ///
  /// In en, this message translates to:
  /// **'Announcement sent to all members!'**
  String get sendAnnouncementSuccess;

  /// No description provided for @viewReactions.
  ///
  /// In en, this message translates to:
  /// **'View Reactions'**
  String get viewReactions;

  /// No description provided for @noReactionsYet.
  ///
  /// In en, this message translates to:
  /// **'No reactions yet'**
  String get noReactionsYet;

  /// No description provided for @titleRequired.
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get titleRequired;

  /// No description provided for @messageRequired.
  ///
  /// In en, this message translates to:
  /// **'Message is required'**
  String get messageRequired;

  /// No description provided for @reactionCount.
  ///
  /// In en, this message translates to:
  /// **'{count} reaction(s)'**
  String reactionCount(int count);

  /// No description provided for @broadcastFrom.
  ///
  /// In en, this message translates to:
  /// **'From {name}'**
  String broadcastFrom(String name);

  /// No description provided for @submitContribution.
  ///
  /// In en, this message translates to:
  /// **'Submit Contribution'**
  String get submitContribution;

  /// No description provided for @contributionRequestSent.
  ///
  /// In en, this message translates to:
  /// **'Contribution request sent! Waiting for admin approval.'**
  String get contributionRequestSent;

  /// No description provided for @contributionRequestInfo.
  ///
  /// In en, this message translates to:
  /// **'Your contribution will be added to the group balance once the admin approves it.'**
  String get contributionRequestInfo;

  /// No description provided for @pendingApprovals.
  ///
  /// In en, this message translates to:
  /// **'Pending Approvals'**
  String get pendingApprovals;

  /// No description provided for @myTotalContributions.
  ///
  /// In en, this message translates to:
  /// **'My Contributions'**
  String get myTotalContributions;

  /// No description provided for @submitRepayment.
  ///
  /// In en, this message translates to:
  /// **'Submit Repayment'**
  String get submitRepayment;

  /// No description provided for @repaymentRequestSent.
  ///
  /// In en, this message translates to:
  /// **'Repayment submitted! Waiting for admin approval.'**
  String get repaymentRequestSent;

  /// No description provided for @repaymentPending.
  ///
  /// In en, this message translates to:
  /// **'You have a repayment pending admin approval.'**
  String get repaymentPending;

  /// No description provided for @pendingRepayments.
  ///
  /// In en, this message translates to:
  /// **'Pending Repayments'**
  String get pendingRepayments;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr', 'rw'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'rw':
      return AppLocalizationsRw();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
