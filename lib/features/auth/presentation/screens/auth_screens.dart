// ═══════════════════════════════ SPLASH SCREEN ═══════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final onboarded = prefs.getBool(AppConstants.prefOnboarded) ?? false;
    final authState = ref.read(authStateProvider);

    if (authState.valueOrNull != null) {
      context.go(AppRoutes.home);
    } else if (!onboarded) {
      context.go(AppRoutes.onboarding);
    } else {
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Icon(Icons.savings_rounded,
                    color: Colors.white, size: 52),
              ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
              const SizedBox(height: 24),
              const Text(
                'Ikimina Digital',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 8),
              const Text(
                'Community Savings, Digitised',
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ).animate().fadeIn(delay: 400.ms),
              const SizedBox(height: 60),
              const CircularProgressIndicator(
                  color: Colors.white, strokeWidth: 2)
                  .animate().fadeIn(delay: 600.ms),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════ ONBOARDING SCREEN ═══════════════════════════════
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageCtrl = PageController();
  int _page = 0;

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefOnboarded, true);
    if (mounted) context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pages = [
      _OnboardPage(
        icon: Icons.groups_rounded,
        color: AppColors.primary,
        title: l10n.onboardingTitle1,
        subtitle: l10n.onboardingSubtitle1,
      ),
      _OnboardPage(
        icon: Icons.track_changes_rounded,
        color: AppColors.secondary,
        title: l10n.onboardingTitle2,
        subtitle: l10n.onboardingSubtitle2,
      ),
      _OnboardPage(
        icon: Icons.account_balance_wallet_rounded,
        color: AppColors.accent,
        title: l10n.onboardingTitle3,
        subtitle: l10n.onboardingSubtitle3,
      ),
      _OnboardPage(
        icon: Icons.picture_as_pdf_rounded,
        color: AppColors.info,
        title: l10n.onboardingTitle4,
        subtitle: l10n.onboardingSubtitle4,
      ),
    ];
    return Scaffold(
      backgroundColor: context.bg,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _finish,
                child: Text(l10n.skip),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageCtrl,
                itemCount: pages.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (_, i) => pages[i],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pages.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: i == _page ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: i == _page
                              ? AppColors.primary
                              : context.borderColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_page < pages.length - 1) {
                          _pageCtrl.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          _finish();
                        }
                      },
                      child: Text(
                          _page < pages.length - 1 ? l10n.continueBtnLabel : l10n.getStarted),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardPage extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  const _OnboardPage({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Icon(icon, size: 56, color: color),
          ).animate().scale(curve: Curves.elasticOut),
          const SizedBox(height: 40),
          Text(title,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center)
              .animate().fadeIn(delay: 100.ms),
          const SizedBox(height: 16),
          Text(subtitle,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center)
              .animate().fadeIn(delay: 200.ms),
        ],
      ),
    );
  }
}

// ═══════════════════════════════ FORGOT PASSWORD ═══════════════════════════════
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailCtrl = TextEditingController();
  bool _loading = false;
  bool _sent = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.resetPassword)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: _sent
            ? _buildSuccess(l10n)
            : _buildForm(l10n),
      ),
    );
  }

  Widget _buildForm(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.resetPasswordInstructions,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 32),
        TextFormField(
          controller: _emailCtrl,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: l10n.email,
            prefixIcon: const Icon(Icons.email_outlined),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _loading
                ? null
                : () async {
                    setState(() => _loading = true);
                    try {
                      await ref
                          .read(authServiceProvider)
                          .sendPasswordReset(_emailCtrl.text.trim());
                      setState(() { _sent = true; _loading = false; });
                    } catch (e) {
                      setState(() => _loading = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  },
            child: _loading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(l10n.sendResetLink),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccess(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: context.primarySurf,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.mark_email_read_outlined,
                size: 40, color: AppColors.primary),
          ).animate().scale(curve: Curves.elasticOut),
          const SizedBox(height: 24),
          Text(l10n.checkYourEmail,
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          Text(
            l10n.resetLinkSentTo(_emailCtrl.text),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),
          OutlinedButton(
            onPressed: () => context.go(AppRoutes.login),
            child: Text(l10n.backToSignIn),
          ),
        ],
      ),
    );
  }
}
