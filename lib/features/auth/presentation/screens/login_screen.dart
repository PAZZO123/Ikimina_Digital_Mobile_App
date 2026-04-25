import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/auth_service.dart';
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
  bool _obscure = true;
  String? _error;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
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

      // Invalidate the cached user so the provider re-subscribes to the
      // newly signed-in user's Firestore document — prevents the previous
      // account's data from briefly appearing.
      ref.invalidate(currentUserProvider);

      if (mounted) context.go(AppRoutes.home);
    } catch (e) {
      if (mounted) {
        setState(() { _error = e.toString(); _loading = false; });
      }
    }
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
                ).animate().fadeIn(delay: 400.ms),

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
                ).animate().fadeIn(delay: 450.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}