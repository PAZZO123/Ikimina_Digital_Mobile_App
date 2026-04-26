import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/app_models.dart';
import '../../../auth/presentation/screens/profile_screen.dart';
import '../../../dashboard/presentation/screens/dashboard_screen.dart';
import '../../../groups/presentation/screens/groups_screen.dart';
import '../../../loans/presentation/screens/loans_screen.dart';

final _navIndexProvider = StateProvider<int>((ref) => 0);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _profileCheckDone = false;
  String? _lastSeenUserId; // track which user is active

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkProfile());
  }

  Future<void> _checkProfile() async {
    if (_profileCheckDone) return;
    _profileCheckDone = true;
    final user = await ref.read(currentUserProvider.future);
    if (user == null) return;
    // If phone is missing, prompt the user to complete their profile
    if (user.phone.isEmpty && mounted) {
      _showCompleteProfileDialog(user.fullName, user.id);
    }
  }

  void _showCompleteProfileDialog(String currentName, String userId) {
    final nameCtrl = TextEditingController(text: currentName);
    final phoneCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        final l10n = AppLocalizations.of(ctx)!;
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 32,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40, height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(l10n.completeYourProfile,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  l10n.completeProfileInstructions,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameCtrl,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: l10n.fullName,
                    prefixIcon: const Icon(Icons.person_outline),
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? l10n.errorRequired : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: phoneCtrl,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: l10n.phone,
                    prefixIcon: const Icon(Icons.phone_outlined),
                    hintText: '07XXXXXXXX',
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? l10n.errorRequired : null,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text(l10n.skip),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!formKey.currentState!.validate()) return;
                          final user =
                              await ref.read(currentUserProvider.future);
                          if (user == null) return;
                          await ref.read(authServiceProvider).updateProfile(
                                user.copyWith(
                                  fullName: nameCtrl.text.trim(),
                                  phone: phoneCtrl.text.trim(),
                                ),
                              );
                          if (ctx.mounted) Navigator.pop(ctx);
                        },
                        child: Text(l10n.save),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(_navIndexProvider);
    final l10n = AppLocalizations.of(context)!;

    // When the signed-in user changes (account switch), reset to the
    // dashboard tab and re-run the profile-completion check.
    ref.listen<AsyncValue<UserModel?>>(currentUserProvider, (prev, next) {
      final prevId = prev?.valueOrNull?.id;
      final nextId = next.valueOrNull?.id;
      if (nextId != null && nextId != prevId) {
        ref.read(_navIndexProvider.notifier).state = 0;
        _profileCheckDone = false;
        _lastSeenUserId = nextId;
        Future.microtask(_checkProfile);
      }
    });

    final screens = [
      const DashboardScreen(),
      const GroupsScreen(),
      const LoansScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: index, children: screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: context.cardSurface,
          border: Border(
            top: BorderSide(color: context.borderColor),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.dashboard_outlined,
                  activeIcon: Icons.dashboard_rounded,
                  label: l10n.dashboard,
                  index: 0,
                  currentIndex: index,
                  onTap: () => ref.read(_navIndexProvider.notifier).state = 0,
                ),
                _NavItem(
                  icon: Icons.group_outlined,
                  activeIcon: Icons.group_rounded,
                  label: l10n.groups,
                  index: 1,
                  currentIndex: index,
                  onTap: () => ref.read(_navIndexProvider.notifier).state = 1,
                ),
                _NavItem(
                  icon: Icons.account_balance_wallet_outlined,
                  activeIcon: Icons.account_balance_wallet_rounded,
                  label: l10n.loans,
                  index: 2,
                  currentIndex: index,
                  onTap: () => ref.read(_navIndexProvider.notifier).state = 2,
                ),
                _NavItem(
                  icon: Icons.person_outline_rounded,
                  activeIcon: Icons.person_rounded,
                  label: l10n.profile,
                  index: 3,
                  currentIndex: index,
                  onTap: () => ref.read(_navIndexProvider.notifier).state = 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int index;
  final int currentIndex;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == currentIndex;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: AppConstants.animShort,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? context.primarySurf : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isActive ? activeIcon : icon,
                color: isActive ? AppColors.primary : context.textHintColor,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  color: isActive ? AppColors.primary : context.textHintColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
