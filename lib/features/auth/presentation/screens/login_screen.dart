import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/group_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/shared_widgets.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _loading = false;
  bool _googleLoading = false;
  bool _obscure = true;
  String? _error;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle() async {
    setState(() { _googleLoading = true; _error = null; });
    try {
      final user = await ref.read(authServiceProvider).signInWithGoogle();
      if (user == null) {
        if (mounted) setState(() => _googleLoading = false);
        return;
      }
      await _resetAndNavigate();
    } catch (e) {
      if (mounted) setState(() { _error = e.toString(); _googleLoading = false; });
    }
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _error = null; });

    try {
      await ref.read(authServiceProvider).login(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text,
      ).timeout(
        const Duration(seconds: 20),
        onTimeout: () => throw 'Connection timed out. Please check your internet connection and try again.',
      );
      await _resetAndNavigate();
    } catch (e) {
      if (mounted) {
        setState(() { _error = e.toString(); _loading = false; });
      }
    }
  }

  /// Clears ALL stale provider state for the previous account, waits for the
  /// new user's Firestore document to resolve, then navigates home.
  /// Without the await on currentUserProvider.future the dashboard renders
  /// before the new userId is known, so userGroupsProvider gets subscribed
  /// with a stale/empty arg and the groups never appear.
  Future<void> _resetAndNavigate() async {
    // 1. Kill every cached data provider from the previous session
    invalidateAllUserDataProviders(ref);
    // 2. Force currentUserProvider to re-subscribe from scratch so it picks
    //    up the new Firebase Auth user immediately
    ref.invalidate(currentUserProvider);
    // 3. Wait until Firestore has resolved the new user document — this
    //    ensures the dashboard renders with the correct userId on first build
    await ref.read(currentUserProvider.future);
    if (mounted) context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: context.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),

                // Logo
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(Icons.savings_rounded,
                      color: Colors.white, size: 32),
                ).animate().fadeIn().slideY(begin: -0.3),

                const SizedBox(height: 24),

                Text(
                  l10n.welcome,
                  style: Theme.of(context).textTheme.displaySmall,
                ).animate().fadeIn(delay: 100.ms),
                const SizedBox(height: 8),
                Text(
                  l10n.signInSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ).animate().fadeIn(delay: 150.ms),

                const SizedBox(height: 40),

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

                AppTextField(
                  controller: _emailCtrl,
                  label: l10n.email,
                  hint: 'you@example.com',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return l10n.errorRequired;
                    if (!v.contains('@')) return l10n.errorInvalidEmail;
                    return null;
                  },
                ).animate().fadeIn(delay: 200.ms),
                const SizedBox(height: 16),

                AppTextField(
                  controller: _passwordCtrl,
                  label: l10n.password,
                  hint: '••••••••',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscure,
                  suffix: IconButton(
                    icon: Icon(_obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return l10n.errorRequired;
                    if (v.length < 6) return l10n.errorPasswordShort;
                    return null;
                  },
                ).animate().fadeIn(delay: 250.ms),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push(AppRoutes.forgotPassword),
                    child: Text(l10n.forgotPassword),
                  ),
                ).animate().fadeIn(delay: 300.ms),

                const SizedBox(height: 8),

                PrimaryButton(
                  label: l10n.signIn,
                  onPressed: _login,
                  isLoading: _loading,
                ).animate().fadeIn(delay: 350.ms),

                const SizedBox(height: 24),

                // ── OR divider ──
                Row(
                  children: [
                    Expanded(child: Divider(color: context.borderColor)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        l10n.orContinueWith,
                        style: TextStyle(
                          fontSize: 12,
                          color: context.textHintColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: context.borderColor)),
                  ],
                ).animate().fadeIn(delay: 380.ms),
                const SizedBox(height: 16),

                // ── Google button ──
                GoogleSignInButton(
                  label: l10n.continueWithGoogle,
                  isLoading: _googleLoading,
                  onTap: _signInWithGoogle,
                ).animate().fadeIn(delay: 400.ms),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.noAccountYet,
                        style: Theme.of(context).textTheme.bodyMedium),
                    TextButton(
                      onPressed: () => context.go(AppRoutes.register),
                      child: Text(l10n.createAccount),
                    ),
                  ],
                ).animate().fadeIn(delay: 440.ms),

                const SizedBox(height: 40),

                // Demo hint
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.primarySurf,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline,
                          color: AppColors.primary, size: 18),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'New to Ikimina Digital? Create a free account to start managing your savings group.',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.primaryDark),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 480.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

