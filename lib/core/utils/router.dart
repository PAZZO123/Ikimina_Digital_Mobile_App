import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_constants.dart';
import '../services/auth_service.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/dashboard/presentation/screens/home_screen.dart';
import '../../features/groups/presentation/screens/groups_screen.dart';
import '../../features/groups/presentation/screens/group_detail_screen.dart';
import '../../features/groups/presentation/screens/create_group_screen.dart';
import '../../features/groups/presentation/screens/group_members_screen.dart';
import '../../features/groups/presentation/screens/send_announcement_screen.dart';
import '../../features/contributions/presentation/screens/add_contribution_screen.dart';
import '../../features/loans/presentation/screens/loans_screen.dart';
import '../../features/loans/presentation/screens/request_loan_screen.dart';
import '../../features/loans/presentation/screens/loan_detail_screen.dart';
import '../../features/reports/presentation/screens/reports_screen.dart';
import '../../features/auth/presentation/screens/profile_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: GoRouterRefreshStream(
      authState.when(
        data: (user) => Stream.value(user),
        loading: () => const Stream.empty(),
        error: (_, __) => const Stream.empty(),
      ),
    ),
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull != null;
      final isAuthRoute = state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.register ||
          state.matchedLocation == AppRoutes.onboarding ||
          state.matchedLocation == AppRoutes.splash ||
          state.matchedLocation == AppRoutes.forgotPassword;

      if (!isLoggedIn && !isAuthRoute) return AppRoutes.login;
      if (isLoggedIn && (state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.register)) {
        return AppRoutes.home;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.groups,
        builder: (context, state) => const GroupsScreen(),
      ),
      GoRoute(
        path: '/groups/create',
        builder: (context, state) => const CreateGroupScreen(),
      ),
      GoRoute(
        path: '/groups/:groupId',
        builder: (context, state) => GroupDetailScreen(
          groupId: state.pathParameters['groupId']!,
        ),
      ),
      GoRoute(
        path: '/groups/:groupId/members',
        builder: (context, state) => GroupMembersScreen(
          groupId: state.pathParameters['groupId']!,
        ),
      ),
      GoRoute(
        path: '/groups/:groupId/announce',
        builder: (context, state) => SendAnnouncementScreen(
          groupId: state.pathParameters['groupId']!,
        ),
      ),
      GoRoute(
        path: '/contributions/add',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return AddContributionScreen(
            groupId: extra?['groupId'] ?? '',
            groupName: extra?['groupName'] ?? '',
          );
        },
      ),
      GoRoute(
        path: AppRoutes.loans,
        builder: (context, state) => const LoansScreen(),
      ),
      GoRoute(
        path: '/loans/request',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return RequestLoanScreen(groupId: extra?['groupId'] ?? '');
        },
      ),
      GoRoute(
        path: '/loans/:loanId',
        builder: (context, state) => LoanDetailScreen(
          loanId: state.pathParameters['loanId']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.reports,
        builder: (context, state) => const ReportsScreen(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Page not found: ${state.uri}'),
            TextButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream stream) {
    stream.listen((_) => notifyListeners());
  }
}
