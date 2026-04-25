import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/shared_widgets.dart';
import '../../../../l10n/app_localizations.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _loading = false;
  bool _obscure = true;
  bool _agreed = false;
  String? _error;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreed) {
      setState(() => _error = AppLocalizations.of(context)!.acceptTermsError);
      return;
    }
    setState(() { _loading = true; _error = null; });

    try {
      await ref.read(authServiceProvider).register(
        fullName: _nameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text,
        phone: _phoneCtrl.text.trim(),
      );
      if (mounted) {
        context.go(AppRoutes.home);
      }
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.go(AppRoutes.login),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.createAccount,
                    style: Theme.of(context).textTheme.displaySmall)
                    .animate().fadeIn(),
                const SizedBox(height: 8),
                Text(l10n.registerSubtitle,
                    style: Theme.of(context).textTheme.bodyMedium)
                    .animate().fadeIn(delay: 50.ms),
                const SizedBox(height: 32),

                if (_error != null)
                  Container(
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.error.withOpacity(0.3)),
                    ),
                    child: Text(_error!,
                        style: const TextStyle(color: AppColors.error, fontSize: 13)),
                  ).animate().fadeIn(),

                AppTextField(
                  controller: _nameCtrl,
                  label: l10n.fullName,
                  hint: 'Amara Uwimana',
                  prefixIcon: Icons.person_outline,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return l10n.nameRequired;
                    if (v.trim().split(' ').length < 2) return l10n.enterFirstLastName;
                    return null;
                  },
                ).animate().fadeIn(delay: 100.ms),
                const SizedBox(height: 16),

                AppTextField(
                  controller: _emailCtrl,
                  label: l10n.email,
                  hint: 'you@example.com',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return l10n.errorRequired;
                    if (!RegExp(r'^[\w-]+@[\w-]+\.\w+$').hasMatch(v)) {
                      return l10n.errorInvalidEmail;
                    }
                    return null;
                  },
                ).animate().fadeIn(delay: 150.ms),
                const SizedBox(height: 16),

                AppTextField(
                  controller: _phoneCtrl,
                  label: l10n.phone,
                  hint: '+250 7XX XXX XXX',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (v) {
                    if (v == null || v.isEmpty) return l10n.phoneRequired;
                    if (v.length < 9) return l10n.enterValidPhone;
                    return null;
                  },
                ).animate().fadeIn(delay: 200.ms),
                const SizedBox(height: 16),

                AppTextField(
                  controller: _passwordCtrl,
                  label: l10n.password,
                  hint: 'Min 8 characters',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscure,
                  suffix: IconButton(
                    icon: Icon(_obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return l10n.passwordRequired;
                    if (v.length < 8) return l10n.errorPasswordShort;
                    return null;
                  },
                ).animate().fadeIn(delay: 250.ms),
                const SizedBox(height: 16),

                AppTextField(
                  controller: _confirmCtrl,
                  label: l10n.confirmPassword,
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscure,
                  validator: (v) {
                    if (v != _passwordCtrl.text) return l10n.errorPasswordMismatch;
                    return null;
                  },
                ).animate().fadeIn(delay: 300.ms),
                const SizedBox(height: 20),

                // Terms
                GestureDetector(
                  onTap: () => setState(() => _agreed = !_agreed),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _agreed,
                        onChanged: (v) => setState(() => _agreed = v ?? false),
                        activeColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: l10n.iAgreeToThe,
                            style: Theme.of(context).textTheme.bodySmall,
                            children: [
                              TextSpan(
                                text: l10n.termsOfService,
                                style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(text: l10n.andWord),
                              TextSpan(
                                text: l10n.privacyPolicy,
                                style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 350.ms),
                const SizedBox(height: 24),

                PrimaryButton(
                  label: l10n.createAccount,
                  onPressed: _register,
                  isLoading: _loading,
                ).animate().fadeIn(delay: 400.ms),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.alreadyHaveAccount,
                        style: Theme.of(context).textTheme.bodyMedium),
                    TextButton(
                      onPressed: () => context.go(AppRoutes.login),
                      child: Text(l10n.signInLink),
                    ),
                  ],
                ).animate().fadeIn(delay: 450.ms),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}