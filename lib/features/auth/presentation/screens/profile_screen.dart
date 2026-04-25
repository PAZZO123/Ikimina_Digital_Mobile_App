// ═══════════════════════ PROFILE SCREEN ═══════════════════════
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/app_models.dart';
import '../../../../shared/widgets/shared_widgets.dart';
import '../../../../main.dart' show localeProvider, themeModeProvider;

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: context.bg,
      appBar: AppBar(
        title: Text(l10n.profile),
        actions: [
          TextButton(
            onPressed: () async {
              await ref.read(authServiceProvider).logout();
              // Clear cached user so the next login starts fresh
              ref.invalidate(currentUserProvider);
              if (context.mounted) context.go(AppRoutes.login);
            },
            child: Text(l10n.signOut, style: const TextStyle(color: AppColors.error)),
          ),
        ],
      ),
      body: userAsync.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (user) {
          if (user == null) return const SizedBox();
          return _ProfileContent(user: user);
        },
      ),
    );
  }
}

class _ProfileContent extends ConsumerStatefulWidget {
  final UserModel user;
  const _ProfileContent({required this.user});

  @override
  ConsumerState<_ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends ConsumerState<_ProfileContent> {
  bool _uploadingPhoto = false;

  Future<void> _pickAndUploadPhoto() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: context.cardSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: context.borderColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: AppColors.primarySurface,
                child: Icon(Icons.photo_library_rounded, color: AppColors.primary),
              ),
              title: const Text('Choose from gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: AppColors.primarySurface,
                child: Icon(Icons.camera_alt_rounded, color: AppColors.primary),
              ),
              title: const Text('Take a photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );

    if (source == null) return;

    final file = await StorageService.pickImage(source: source);
    if (file == null) return;

    setState(() => _uploadingPhoto = true);
    try {
      final url = await StorageService.uploadProfilePicture(file, widget.user.id);
      await ref.read(authServiceProvider).updateProfile(
            widget.user.copyWith(profileImageUrl: url),
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile photo updated!'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update photo: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _uploadingPhoto = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Avatar & Name
        Center(
          child: Column(
            children: [
              Stack(
                children: [
                  _uploadingPhoto
                      ? Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.primarySurf,
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: AppColors.primary),
                          ),
                        )
                      : MemberAvatar(
                          name: user.fullName,
                          imageUrl: user.profileImageUrl,
                          size: 90,
                          backgroundColor: context.primarySurf,
                        ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _uploadingPhoto ? null : _pickAndUploadPhoto,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt_rounded,
                            color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(user.fullName,
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: context.primarySurf,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  user.role.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(),

        const SizedBox(height: 32),

        // Info Section
        _SectionHeader(title: AppLocalizations.of(context)!.accountInfo),
        _ProfileTile(
          icon: Icons.email_outlined,
          label: AppLocalizations.of(context)!.email,
          value: user.email,
        ),
        _ProfileTile(
          icon: Icons.phone_outlined,
          label: AppLocalizations.of(context)!.phone,
          value: user.phone,
        ),
        _ProfileTile(
          icon: Icons.badge_outlined,
          label: AppLocalizations.of(context)!.memberId,
          value: user.id.substring(0, 8).toUpperCase(),
        ),

        const SizedBox(height: 24),

        // Settings Section
        _SectionHeader(title: AppLocalizations.of(context)!.settings),
        _SettingsTile(
          icon: Icons.language_rounded,
          label: AppLocalizations.of(context)!.language,
          trailing: DropdownButton<String>(
            value: user.preferredLanguage,
            underline: const SizedBox(),
            items: const [
              DropdownMenuItem(value: 'en', child: Text('English')),
              DropdownMenuItem(value: 'rw', child: Text('Kinyarwanda')),
              DropdownMenuItem(value: 'fr', child: Text('Français')),
            ],
            onChanged: (lang) async {
              if (lang == null) return;
              ref.read(localeProvider.notifier).state = Locale(lang);
              await ref.read(authServiceProvider).updateProfile(
                    user.copyWith(preferredLanguage: lang),
                  );
            },
          ),
        ),
        _SettingsTile(
          icon: Icons.dark_mode_outlined,
          label: AppLocalizations.of(context)!.darkMode,
          trailing: Switch(
            value: ref.watch(themeModeProvider) == ThemeMode.dark,
            onChanged: (isDark) async {
              final mode = isDark ? ThemeMode.dark : ThemeMode.light;
              ref.read(themeModeProvider.notifier).state = mode;
              // Persist to Firestore
              await ref.read(authServiceProvider).updateProfile(
                    user.copyWith(
                        preferredTheme: isDark ? 'dark' : 'light'),
                  );
            },
            activeColor: AppColors.primary,
          ),
        ),
        _SettingsTile(
          icon: Icons.notifications_outlined,
          label: AppLocalizations.of(context)!.pushNotifications,
          trailing: Switch(
            value: true,
            onChanged: (_) {},
            activeColor: AppColors.primary,
          ),
        ),
        _SettingsTile(
          icon: Icons.fingerprint_rounded,
          label: AppLocalizations.of(context)!.biometricLogin,
          trailing: Switch(
            value: user.biometricEnabled,
            onChanged: (_) {},
            activeColor: AppColors.primary,
          ),
        ),

        const SizedBox(height: 24),

        // Danger Zone
        _SectionHeader(title: AppLocalizations.of(context)!.account),
        _SettingsTile(
          icon: Icons.lock_reset_rounded,
          label: AppLocalizations.of(context)!.changePassword,
          trailing: Icon(Icons.chevron_right_rounded,
              color: context.textHintColor),
          onTap: () {},
        ),
        _SettingsTile(
          icon: Icons.delete_outline_rounded,
          label: AppLocalizations.of(context)!.deleteAccount,
          color: AppColors.error,
          trailing: Icon(Icons.chevron_right_rounded,
              color: context.textHintColor),
          onTap: () {},
        ),

        const SizedBox(height: 40),
        Center(
          child: Text(
            '${AppConstants.appName} v${AppConstants.appVersion}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              letterSpacing: 1,
              color: context.textHintColor,
            ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProfileTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.borderColor),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: 2),
              Text(value, style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? color;

  const _SettingsTile({
    required this.icon,
    required this.label,
    this.trailing,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: context.cardSurface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: context.borderColor),
        ),
        child: Row(
          children: [
            Icon(icon,
                size: 20, color: color ?? context.textSec),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: color),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
