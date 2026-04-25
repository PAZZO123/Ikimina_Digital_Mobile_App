// ═══════════════════════════ GROUPS SCREEN ═══════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/auth_service.dart';
import '../../../../core/services/group_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/app_models.dart';
import '../../../../shared/widgets/shared_widgets.dart';

class GroupsScreen extends ConsumerWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

    return userAsync.when(
      loading: () => const LoadingWidget(),
      error: (e, _) => Center(child: Text(e.toString())),
      data: (user) {
        if (user == null) return const SizedBox();

        final groupsAsync = ref.watch(userGroupsProvider(user.id));

        final l10n = AppLocalizations.of(context)!;
        return Scaffold(
          backgroundColor: context.bg,
          appBar: AppBar(
            title: Text(l10n.myGroups),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_rounded),
                onPressed: () => context.push('/groups/create'),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showJoinDialog(context, ref),
            icon: const Icon(Icons.group_add_rounded),
            label: Text(l10n.joinGroup),
            backgroundColor: AppColors.secondary,
          ),
          body: groupsAsync.when(
            loading: () => LoadingWidget(message: AppLocalizations.of(context)!.loadingGroups),
            error: (e, _) => Center(child: Text(e.toString())),
            data: (groups) => groups.isEmpty
                ? EmptyState(
                    icon: Icons.group_outlined,
                    title: l10n.noGroups,
                    subtitle:
                        'Create a new Ikimina group or join an existing one with an invite code.',
                    action: Column(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => context.push('/groups/create'),
                          icon: const Icon(Icons.add_rounded),
                          label: Text(l10n.createGroup),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: () => _showJoinDialog(context, ref),
                          icon: const Icon(Icons.qr_code_scanner_rounded),
                          label: Text(l10n.joinWithCode),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: groups.length,
                    itemBuilder: (ctx, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _GroupCard(
                        group: groups[i],
                        currentUserId: user.id,
                      )
                          .animate()
                          .fadeIn(delay: Duration(milliseconds: i * 80))
                          .slideY(begin: 0.2),
                    ),
                  ),
          ),
        );
      },
    );
  }

  void _showJoinDialog(BuildContext context, WidgetRef ref) {
    final ctrl = TextEditingController();
    bool loading = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) {
          final l10n = AppLocalizations.of(ctx)!;
          return Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 24,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: context.borderColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(l10n.joinAGroup,
                    style: Theme.of(ctx).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(l10n.joinGroupInstructions,
                    style: Theme.of(ctx).textTheme.bodyMedium),
                const SizedBox(height: 24),
                TextField(
                  controller: ctrl,
                  textCapitalization: TextCapitalization.characters,
                  maxLength: 6,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 8),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'XXXXXX',
                    counterText: '',
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: loading
                        ? null
                        : () async {
                            if (ctrl.text.trim().length < 6) {
                              ScaffoldMessenger.of(ctx).showSnackBar(
                                SnackBar(content: Text(l10n.enterValidCode)),
                              );
                              return;
                            }
                            setState(() => loading = true);
                            try {
                              final user = ref.read(currentUserProvider).valueOrNull;
                              if (user == null) throw 'Not logged in.';
                              await ref
                                  .read(groupServiceProvider)
                                  .submitJoinRequest(
                                    inviteCode: ctrl.text.trim(),
                                    user: user,
                                  );
                              if (ctx.mounted) Navigator.pop(ctx);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '✅ ${AppLocalizations.of(context)!.requestSentWaiting}'),
                                    duration: const Duration(seconds: 4),
                                  ),
                                );
                              }
                            } catch (e) {
                              setState(() => loading = false);
                              if (ctx.mounted) {
                                ScaffoldMessenger.of(ctx).showSnackBar(
                                  SnackBar(content: Text(e.toString())),
                                );
                              }
                            }
                          },
                    child: loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(l10n.sendRequest),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _GroupCard extends ConsumerWidget {
  final GroupModel group;
  final String currentUserId;
  const _GroupCard({required this.group, required this.currentUserId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = group.currentPayoutIndex /
        (group.memberIds.isEmpty ? 1 : group.memberIds.length);
    final isAdmin = group.adminId == currentUserId;
    final pendingCount = isAdmin
        ? (ref.watch(groupJoinRequestsProvider(group.id)).valueOrNull?.length ?? 0)
        : 0;

    return GestureDetector(
      onTap: () => context.push('/groups/${group.id}'),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.cardSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: context.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.savings_rounded,
                      color: Colors.white, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(group.name,
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.people_outline_rounded,
                              size: 13, color: context.textSec),
                          const SizedBox(width: 4),
                          Text('${group.memberIds.length} members',
                              style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(width: 12),
                          Icon(Icons.repeat_rounded,
                              size: 13, color: context.textSec),
                          const SizedBox(width: 4),
                          Text(group.contributionFrequency,
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                ),
                if (pendingCount > 0)
                  Container(
                    margin: const EdgeInsets.only(right: 6),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.warning,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.how_to_reg_rounded,
                            size: 11, color: Colors.white),
                        const SizedBox(width: 4),
                        Text('$pendingCount',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                StatusBadge(group.status),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.balance,
                          style: Theme.of(context).textTheme.labelSmall),
                      const SizedBox(height: 4),
                      Text(formatRWF(group.totalBalance),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: AppColors.primary)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.contribution,
                          style: Theme.of(context).textTheme.labelSmall),
                      const SizedBox(height: 4),
                      Text(formatRWF(group.contributionAmount),
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LabeledProgress(
              label: AppLocalizations.of(context)!.payoutCycleProgress,
              progress: progress,
              leftLabel: 'Round ${group.currentPayoutIndex + 1}',
              rightLabel: '${group.memberIds.length} total',
            ),
          ],
        ),
      ),
    );
  }
}