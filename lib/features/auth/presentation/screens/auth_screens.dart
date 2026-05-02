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
import '../../../../shared/widgets/shared_widgets.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  bool _loading = false;
  bool _sent = false;
  String? _error;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _error = null; });
    try {
      await ref
          .read(authServiceProvider)
          .sendPasswordReset(_emailCtrl.text.trim());
      if (mounted) setState(() { _sent = true; _loading = false; });
    } catch (e) {
      if (mounted) setState(() { _error = e.toString(); _loading = false; });
    }
  }

  Future<void> _resend() async {
    setState(() { _loading = true; _error = null; });
    try {
      await ref
          .read(authServiceProvider)
          .sendPasswordReset(_emailCtrl.text.trim());
      if (mounted) {
        setState(() => _loading = false);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Reset link resent! Check your inbox.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) setState(() { _error = e.toString(); _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: context.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.go(AppRoutes.login),
        ),
      ),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, anim) => FadeTransition(
            opacity: anim,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.05, 0),
                end: Offset.zero,
              ).animate(anim),
              child: child,
            ),
          ),
          child: _sent
              ? _buildSuccess(l10n)
              : _buildForm(l10n),
        ),
      ),
    );
  }

  Widget _buildForm(AppLocalizations l10n) {
    return SingleChildScrollView(
      key: const ValueKey('form'),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // ── Icon ──
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.lock_reset_rounded,
                  size: 36, color: Colors.white),
            ).animate().scale(curve: Curves.elasticOut),
            const SizedBox(height: 24),

            Text(l10n.resetPassword,
                style: Theme.of(context).textTheme.displaySmall)
                .animate().fadeIn(delay: 100.ms),
            const SizedBox(height: 8),
            Text(l10n.resetPasswordInstructions,
                style: Theme.of(context).textTheme.bodyMedium)
                .animate().fadeIn(delay: 150.ms),
            const SizedBox(height: 32),

            // ── Error banner ──
            if (_error != null)
              Container(
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.error.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline,
                        color: AppColors.error, size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(_error!,
                          style: const TextStyle(
                              color: AppColors.error, fontSize: 13)),
                    ),
                  ],
                ),
              ).animate().fadeIn().shakeX(),

            // ── Email field ──
            AppTextField(
              controller: _emailCtrl,
              label: l10n.email,
              hint: 'you@example.com',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: (v) {
                if (v == null || v.isEmpty) return l10n.errorRequired;
                if (!v.contains('@')) return l10n.errorInvalidEmail;
                return null;
              },
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 24),

            PrimaryButton(
              label: l10n.sendResetLink,
              onPressed: _send,
              isLoading: _loading,
            ).animate().fadeIn(delay: 250.ms),
            const SizedBox(height: 20),

            Center(
              child: TextButton(
                onPressed: () => context.go(AppRoutes.login),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.arrow_back_ios_rounded, size: 14),
                    const SizedBox(width: 4),
                    Text(l10n.backToSignIn),
                  ],
                ),
              ),
            ).animate().fadeIn(delay: 300.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccess(AppLocalizations l10n) {
    return SingleChildScrollView(
      key: const ValueKey('success'),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 48),

          // ── Animated icon ──
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(Icons.mark_email_read_rounded,
                size: 50, color: Colors.white),
          )
              .animate()
              .scale(curve: Curves.elasticOut, duration: 700.ms)
              .then()
              .shimmer(duration: 1200.ms,
                  color: Colors.white.withOpacity(0.4)),
          const SizedBox(height: 32),

          Text(l10n.checkYourEmail,
              style: Theme.of(context).textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center)
              .animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 12),

          Text(
            l10n.resetLinkSentTo(_emailCtrl.text.trim()),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge
                ?.copyWith(color: context.textPrim),
          ).animate().fadeIn(delay: 300.ms),
          const SizedBox(height: 8),

          Text(
            'If you don\'t see it, check your spam folder.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: context.textHintColor),
          ).animate().fadeIn(delay: 350.ms),
          const SizedBox(height: 40),

          // ── Info tile ──
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.primarySurf,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline,
                    color: AppColors.primary, size: 20),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Click the link in the email to set a new password. '
                    'The link expires in 1 hour.',
                    style: TextStyle(fontSize: 13, color: AppColors.primaryDark),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 400.ms),
          const SizedBox(height: 32),

          PrimaryButton(
            label: l10n.backToSignIn,
            onPressed: () => context.go(AppRoutes.login),
          ).animate().fadeIn(delay: 500.ms),
          const SizedBox(height: 16),

          // ── Resend ──
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(l10n.didntReceiveEmail,
                  style: Theme.of(context).textTheme.bodyMedium),
              TextButton(
                onPressed: _loading ? null : _resend,
                child: _loading
                    ? const SizedBox(
                        width: 16, height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.resend),
              ),
            ],
          ).animate().fadeIn(delay: 600.ms),

          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(_error!,
                  style: const TextStyle(color: AppColors.error, fontSize: 13),
                  textAlign: TextAlign.center),
            ).animate().fadeIn(),
        ],
      ),
    );
  }
}
