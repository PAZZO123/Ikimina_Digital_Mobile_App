import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/group_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/app_models.dart';
import '../../../../shared/widgets/shared_widgets.dart';
import 'send_announcement_screen.dart';

class GroupDetailScreen extends ConsumerStatefulWidget {
  final String groupId;
  const GroupDetailScreen({super.key, required this.groupId});

  @override
  ConsumerState<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends ConsumerState<GroupDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final groupAsync = ref.watch(groupStreamProvider(widget.groupId));
    final currentUser = ref.watch(currentUserProvider).valueOrNull;

    return groupAsync.when(
      loading: () => const Scaffold(body: LoadingWidget()),
      error: (e, _) => Scaffold(body: Center(child: Text(e.toString()))),
      data: (group) {
        if (group == null) {
          return Scaffold(body: Center(child: Text(l10n.groupNotFound)));
        }

        final isAdmin = currentUser?.id == group.adminId;

        return Scaffold(
          backgroundColor: context.bg,
          body: NestedScrollView(
            headerSliverBuilder: (ctx, scrolled) => [
              SliverAppBar(
                expandedHeight: 220,
                pinned: true,
                backgroundColor: AppColors.primary,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white),
                  onPressed: () => context.pop(),
                ),
                actions: [
                  if (isAdmin)
                    Consumer(
                      builder: (ctx, ref, _) {
                        final pendingCount = ref
                            .watch(groupJoinRequestsProvider(group.id))
                            .valueOrNull
                            ?.length ?? 0;
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert,
                                  color: Colors.white),
                              onSelected: (val) =>
                                  _handleAdminAction(val, group, context),
                              itemBuilder: (_) => [
                                PopupMenuItem(
                                  value: 'requests',
                                  child: Row(
                                    children: [
                                      const Icon(Icons.how_to_reg_rounded,
                                          size: 18),
                                      const SizedBox(width: 10),
                                      Text(l10n.joinRequests),
                                      if (pendingCount > 0) ...[
                                        const Spacer(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: AppColors.warning,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text('$pendingCount',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                    value: 'payout',
                                    child: Row(children: [
                                      const Icon(Icons.payments_outlined, size: 18),
                                      const SizedBox(width: 10),
                                      Text(l10n.processPayout),
                                    ])),
                                PopupMenuItem(
                                    value: 'fine',
                                    child: Row(children: [
                                      const Icon(Icons.gavel_rounded, size: 18),
                                      const SizedBox(width: 10),
                                      Text(l10n.issueFine),
                                    ])),
                                PopupMenuItem(
                                    value: 'invite',
                                    child: Row(children: [
                                      const Icon(Icons.share_rounded, size: 18),
                                      const SizedBox(width: 10),
                                      Text(l10n.shareInviteCode),
                                    ])),
                                PopupMenuItem(
                                    value: 'announce',
                                    child: Row(children: [
                                      const Icon(Icons.campaign_rounded,
                                          size: 18, color: AppColors.accent),
                                      const SizedBox(width: 10),
                                      Text(l10n.sendAnnouncement,
                                          style: const TextStyle(
                                              color: AppColors.accent)),
                                    ])),
                              ],
                            ),
                            // Red badge dot when there are pending requests
                            if (pendingCount > 0)
                              Positioned(
                                right: 6,
                                top: 6,
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: AppColors.warning,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                    ),
                    padding: const EdgeInsets.fromLTRB(24, 80, 24, 58),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          group.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          group.description,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                bottom: TabBar(
                  controller: _tabCtrl,
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white60,
                  indicatorWeight: 3,
                  tabs: [
                    Tab(text: l10n.tabOverview),
                    Tab(text: l10n.tabContribute),
                    Tab(text: l10n.loans),
                    Tab(text: l10n.tabPayouts),
                    Tab(text: l10n.announcements),
                  ],
                ),
              ),
            ],
            body: TabBarView(
              controller: _tabCtrl,
              children: [
                _OverviewTab(group: group, isAdmin: isAdmin),
                _ContributionsTab(group: group, isAdmin: isAdmin),
                _LoansTab(group: group, isAdmin: isAdmin),
                _PayoutsTab(group: group),
                _AnnouncementsTab(group: group, isAdmin: isAdmin),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleAdminAction(
      String action, GroupModel group, BuildContext context) async {
    final service = ref.read(groupServiceProvider);
    switch (action) {
      case 'requests':
        // Jump to Overview tab (index 0) where requests section lives
        _tabCtrl.animateTo(0);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('📋 Join Requests are shown at the top of Overview'),
              duration: Duration(seconds: 2),
            ),
          );
        }
        break;
      case 'payout':
        final l10nDialog = AppLocalizations.of(context)!;
        final confirm = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(l10nDialog.processPayoutQuestion),
            content: Text(
                'This will pay out ${formatRWF(group.contributionAmount * group.memberIds.length)} to the next member in the rotation.'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: Text(l10nDialog.cancel)),
              ElevatedButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: Text(l10nDialog.processPayout)),
            ],
          ),
        );
        if (confirm == true) {
          try {
            await service.processPayout(group.id);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10nDialog.payoutProcessed)),
              );
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }
        }
        break;
      case 'invite':
        if (group.inviteCode != null && context.mounted) {
          _showInviteDialog(context, group);
        }
        break;
      case 'announce':
        if (context.mounted) {
          context.push('/groups/${group.id}/announce');
        }
        break;
    }
  }

  void _showInviteDialog(BuildContext context, GroupModel group) {
    final l10n = AppLocalizations.of(context)!;
    final code = group.inviteCode!;
    final message =
        'Join my Ikimina group "${group.name}"!\nUse invite code: $code\nDownload Ikimina Digital to join.';

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.borderColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(l10n.shareInviteCode,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Share this code with the person you want to invite.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: Text(
                code,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 10,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.copy_rounded),
                    label: Text(l10n.copyCode),
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: code));
                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.inviteCodeCopied)),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.share_rounded),
                    label: Text(l10n.copyMessage),
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: message));
                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.inviteMessageCopied),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

// ─── Overview Tab ───
class _OverviewTab extends ConsumerWidget {
  final GroupModel group;
  final bool isAdmin;

  const _OverviewTab({required this.group, required this.isAdmin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // ─── Pending Join Requests (admin only) ───
          if (isAdmin) ...[
            _JoinRequestsSection(group: group),
            const SizedBox(height: 16),
          ],
          // Balance cards
          Row(
            children: [
              Expanded(
                child: StatCard(
                  label: l10n.balance,
                  value: formatCompact(group.totalBalance),
                  icon: Icons.account_balance_wallet_rounded,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  label: l10n.contributed,
                  value: formatCompact(group.totalContributed),
                  icon: Icons.trending_up_rounded,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: StatCard(
                  label: l10n.loanedOut,
                  value: formatCompact(group.totalLoaned),
                  icon: Icons.credit_card_rounded,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  label: l10n.members,
                  value: '${group.memberIds.length}',
                  icon: Icons.people_rounded,
                  color: AppColors.info,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Payout progress
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: context.cardSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: context.borderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.payoutCycle,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 16),
                LabeledProgress(
                  label: l10n.progress,
                  progress: group.currentPayoutIndex /
                      (group.memberIds.isEmpty ? 1 : group.memberIds.length),
                  leftLabel: 'Round ${group.currentPayoutIndex + 1}',
                  rightLabel:
                      '${group.memberIds.length - group.currentPayoutIndex} remaining',
                ),
                const SizedBox(height: 16),
                if (group.nextContributionDate != null)
                  _InfoRow(
                    icon: Icons.calendar_today_outlined,
                    label: l10n.nextContribution,
                    value: DateFormat('EEE, d MMM yyyy')
                        .format(group.nextContributionDate!),
                  ),
                _InfoRow(
                  icon: Icons.repeat_rounded,
                  label: l10n.contributionFrequency,
                  value: group.contributionFrequency.toUpperCase(),
                ),
                _InfoRow(
                  icon: Icons.payments_outlined,
                  label: l10n.perContribution,
                  value: formatRWF(group.contributionAmount),
                ),
                if (group.inviteCode != null)
                  _InfoRow(
                    icon: Icons.vpn_key_outlined,
                    label: l10n.inviteCode,
                    value: group.inviteCode!,
                    onTap: () async {
                      await Clipboard.setData(
                          ClipboardData(text: group.inviteCode!));
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.codeCopied)),
                        );
                      }
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // View Members
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () =>
                  context.push('/groups/${group.id}/members'),
              icon: const Icon(Icons.people_outline_rounded),
              label: Text(l10n.viewAllMembers),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, size: 16, color: AppColors.primary),
            const SizedBox(width: 10),
            Text('$label:', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.textPrim),
                textAlign: TextAlign.right,
              ),
            ),
            if (onTap != null)
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Icon(Icons.copy_outlined,
                    size: 14, color: AppColors.primary),
              ),
          ],
        ),
      ),
    );
  }
}

// ─── Contributions Tab ───
// Provider for pending contribution requests
final _pendingContribRequestsProvider =
    StreamProvider.family<List<ContributionRequest>, String>((ref, groupId) {
  return ref.read(groupServiceProvider).streamContributionRequests(groupId);
});

class _ContributionsTab extends ConsumerWidget {
  final GroupModel group;
  final bool isAdmin;

  const _ContributionsTab({required this.group, required this.isAdmin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final contribAsync = ref.watch(groupContributionsProvider(group.id));
    final pendingAsync =
        ref.watch(_pendingContribRequestsProvider(group.id));
    final currentUser = ref.watch(currentUserProvider).valueOrNull;

    final pendingRequests = pendingAsync.valueOrNull ?? [];

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/contributions/add',
            extra: {'groupId': group.id, 'groupName': group.name}),
        icon: const Icon(Icons.add_rounded),
        label: Text(l10n.submitContribution),
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Pending requests section (admin sees all; member sees own) ──
          if (pendingRequests.isNotEmpty || isAdmin) ...[
            if (pendingRequests.isNotEmpty) ...[
              _SectionHeader(
                title: l10n.pendingApprovals,
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${pendingRequests.length}',
                    style: const TextStyle(
                        color: AppColors.warning,
                        fontWeight: FontWeight.w700,
                        fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ...pendingRequests.map((req) => _ContribRequestTile(
                    req: req,
                    isAdmin: isAdmin,
                    currentUser: currentUser,
                    group: group,
                  )),
              const SizedBox(height: 16),
            ],
          ],

          // ── Approved contributions list ──
          contribAsync.when(
            loading: () => const LoadingWidget(),
            error: (e, _) => Center(child: Text(e.toString())),
            data: (contribs) {
              if (contribs.isEmpty && pendingRequests.isEmpty) {
                return EmptyState(
                  icon: Icons.payments_outlined,
                  title: l10n.noContributions,
                  subtitle: l10n.noContributionsSubtitle,
                );
              }
              if (contribs.isEmpty) return const SizedBox();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionHeader(title: l10n.approved),
                  const SizedBox(height: 8),
                  ...contribs.map((c) => _ContribTile(c: c)),
                ],
              );
            },
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

// ── Section header helper ──
class _SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  const _SectionHeader({required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        const Spacer(),
        if (trailing != null) trailing!,
      ],
    );
  }
}

// ── Pending contribution request tile ──
class _ContribRequestTile extends ConsumerStatefulWidget {
  final ContributionRequest req;
  final bool isAdmin;
  final UserModel? currentUser;
  final GroupModel group;
  const _ContribRequestTile({
    required this.req,
    required this.isAdmin,
    required this.currentUser,
    required this.group,
  });

  @override
  ConsumerState<_ContribRequestTile> createState() =>
      _ContribRequestTileState();
}

class _ContribRequestTileState
    extends ConsumerState<_ContribRequestTile> {
  bool _loading = false;

  Future<void> _approve() async {
    setState(() => _loading = true);
    try {
      await ref.read(groupServiceProvider).approveContributionRequest(
            requestId: widget.req.id,
            adminId: widget.currentUser!.id,
            adminName: widget.currentUser!.fullName,
          );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _reject() async {
    setState(() => _loading = true);
    try {
      await ref.read(groupServiceProvider).rejectContributionRequest(
            requestId: widget.req.id,
            adminId: widget.currentUser!.id,
            adminName: widget.currentUser!.fullName,
          );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.warningSurf,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.warning.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.hourglass_top_rounded,
                    color: AppColors.warning, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.req.memberName,
                        style: Theme.of(context).textTheme.titleSmall),
                    if (widget.req.note != null &&
                        widget.req.note!.isNotEmpty)
                      Text(widget.req.note!,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              Text(
                '+${formatRWF(widget.req.amount)}',
                style: const TextStyle(
                    color: AppColors.warning,
                    fontWeight: FontWeight.w700,
                    fontSize: 14),
              ),
            ],
          ),
          if (widget.isAdmin) ...[
            const SizedBox(height: 10),
            _loading
                ? const Center(
                    child: SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2)))
                : Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _reject,
                          icon: const Icon(Icons.close_rounded, size: 16),
                          label: Text(l10n.reject),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.error,
                            side:
                                const BorderSide(color: AppColors.error),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _approve,
                          icon: const Icon(Icons.check_rounded, size: 16),
                          label: Text(l10n.approve),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.success,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ],
      ),
    );
  }
}

class _ContribTile extends StatelessWidget {
  final ContributionModel c;
  const _ContribTile({required this.c});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.cardSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: context.primarySurf,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.payments_rounded,
                color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c.memberName,
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 2),
                Text(
                  DateFormat('d MMM yyyy · HH:mm').format(c.contributionDate),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '+${formatRWF(c.amount)}',
                style: const TextStyle(
                  color: AppColors.success,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              StatusBadge(c.status),
            ],
          ),
        ],
      ),
    );
  }
}

// Provider for pending repayment requests
final _pendingRepaymentRequestsProvider =
    StreamProvider.family<List<RepaymentRequest>, String>((ref, groupId) {
  return ref.read(groupServiceProvider).streamRepaymentRequests(groupId);
});

// ─── Loans Tab ───
class _LoansTab extends ConsumerWidget {
  final GroupModel group;
  final bool isAdmin;

  const _LoansTab({required this.group, required this.isAdmin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final loansAsync = ref.watch(groupLoansProvider(group.id));
    final repaymentPendingAsync =
        ref.watch(_pendingRepaymentRequestsProvider(group.id));
    final currentUser = ref.watch(currentUserProvider).valueOrNull;
    final currentUserId = currentUser?.id ?? '';

    final pendingRepayments = repaymentPendingAsync.valueOrNull ?? [];

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            context.push('/loans/request', extra: {'groupId': group.id}),
        icon: const Icon(Icons.add_rounded),
        label: Text(l10n.requestLoan),
        backgroundColor: AppColors.accent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Pending repayment requests (admin sees all) ──
          if (isAdmin && pendingRepayments.isNotEmpty) ...[
            _SectionHeader(
              title: l10n.pendingRepayments,
              trailing: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${pendingRepayments.length}',
                  style: const TextStyle(
                      color: AppColors.warning,
                      fontWeight: FontWeight.w700,
                      fontSize: 12),
                ),
              ),
            ),
            const SizedBox(height: 8),
            ...pendingRepayments.map((req) => _RepaymentRequestTile(
                  req: req,
                  currentUser: currentUser,
                )),
            const SizedBox(height: 16),
          ],

          // ── Loans list ──
          loansAsync.when(
            loading: () => const LoadingWidget(),
            error: (e, _) => Center(child: Text(e.toString())),
            data: (loans) {
              if (loans.isEmpty && pendingRepayments.isEmpty) {
                return EmptyState(
                  icon: Icons.account_balance_wallet_outlined,
                  title: l10n.noLoansYet,
                  subtitle: l10n.noLoansSubtitle,
                );
              }
              if (loans.isEmpty) return const SizedBox();
              final pending = loans
                  .where((l) => l.status == AppConstants.statusPending)
                  .toList();
              final others = loans
                  .where((l) => l.status != AppConstants.statusPending)
                  .toList();
              final sorted = [...pending, ...others];
              return Column(
                children: sorted
                    .map((l) => _LoanTile(
                          loan: l,
                          isAdmin: isAdmin,
                          currentUserId: currentUserId,
                        ))
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

// ── Pending repayment request tile (admin view) ──
class _RepaymentRequestTile extends ConsumerStatefulWidget {
  final RepaymentRequest req;
  final UserModel? currentUser;
  const _RepaymentRequestTile(
      {required this.req, required this.currentUser});

  @override
  ConsumerState<_RepaymentRequestTile> createState() =>
      _RepaymentRequestTileState();
}

class _RepaymentRequestTileState
    extends ConsumerState<_RepaymentRequestTile> {
  bool _loading = false;

  Future<void> _approve() async {
    setState(() => _loading = true);
    try {
      await ref.read(groupServiceProvider).approveRepaymentRequest(
            requestId: widget.req.id,
            adminId: widget.currentUser!.id,
            adminName: widget.currentUser!.fullName,
          );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _reject() async {
    setState(() => _loading = true);
    try {
      await ref.read(groupServiceProvider).rejectRepaymentRequest(
            requestId: widget.req.id,
            adminId: widget.currentUser!.id,
          );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.warningSurf,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.warning.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.payment_rounded,
                    color: AppColors.warning, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.req.memberName,
                        style: Theme.of(context).textTheme.titleSmall),
                    Text('Loan repayment request',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              Text(
                formatRWF(widget.req.amount),
                style: const TextStyle(
                    color: AppColors.warning,
                    fontWeight: FontWeight.w700,
                    fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _loading
              ? const Center(
                  child: SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2)))
              : Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _reject,
                        icon: const Icon(Icons.close_rounded, size: 16),
                        label: Text(l10n.reject),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.error,
                          side: const BorderSide(color: AppColors.error),
                          padding:
                              const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _approve,
                        icon: const Icon(Icons.check_rounded, size: 16),
                        label: Text(l10n.approve),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.success,
                          foregroundColor: Colors.white,
                          padding:
                              const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _LoanTile extends ConsumerStatefulWidget {
  final LoanModel loan;
  final bool isAdmin;
  final String currentUserId;

  const _LoanTile({
    required this.loan,
    required this.isAdmin,
    required this.currentUserId,
  });

  @override
  ConsumerState<_LoanTile> createState() => _LoanTileState();
}

class _LoanTileState extends ConsumerState<_LoanTile> {
  bool _loading = false;

  Future<void> _updateStatus(String status) async {
    setState(() => _loading = true);
    try {
      await ref.read(groupServiceProvider).updateLoanStatus(
            widget.loan.id, status, widget.currentUserId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(status == AppConstants.statusApproved
              ? '✅ Loan approved for ${widget.loan.borrowerName}'
              : '❌ Loan request rejected'),
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final loan = widget.loan;
    final isPending = loan.status == AppConstants.statusPending;
    final isMyLoan = loan.borrowerId == widget.currentUserId;

    return GestureDetector(
      onTap: () => context.push('/loans/${loan.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: context.cardSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isPending
                ? AppColors.warning.withOpacity(0.6)
                : context.borderColor,
            width: isPending ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header: avatar + name + status ──
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
              child: Row(
                children: [
                  MemberAvatar(name: loan.borrowerName, size: 38),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                loan.borrowerName,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                            if (isMyLoan)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: context.primarySurf,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(l10n.you,
                                    style: const TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700)),
                              ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          loan.purpose ?? l10n.noPurpose,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: context.textSec),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  StatusBadge(loan.status),
                ],
              ),
            ),

            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),

            // ── Amounts row ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Expanded(
                    child: _LoanStat(
                        label: l10n.amount,
                        value: formatRWF(loan.amount),
                        color: AppColors.accent),
                  ),
                  Expanded(
                    child: _LoanStat(
                        label: l10n.interestRate,
                        value: '${loan.interestRate}%'),
                  ),
                  Expanded(
                    child: _LoanStat(
                        label: l10n.duration,
                        value: '${loan.durationMonths} months'),
                  ),
                ],
              ),
            ),

            // ── Repayment progress (approved loans) ──
            if (loan.status == AppConstants.statusApproved) ...[
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: LabeledProgress(
                  label: l10n.repaymentSummary,
                  progress: loan.repaymentProgress,
                  leftLabel: formatRWF(loan.amountRepaid),
                  rightLabel: formatRWF(loan.totalDue),
                  color: AppColors.accent,
                ),
              ),
            ],

            // ── Admin approve/reject (pending loans only) ──
            if (isPending && widget.isAdmin) ...[
              const SizedBox(height: 12),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
                child: _loading
                    ? const Center(
                        child: SizedBox(
                          height: 32,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : Row(
                        children: [
                          Icon(Icons.admin_panel_settings_rounded,
                              size: 14, color: context.textHintColor),
                          const SizedBox(width: 6),
                          Text(l10n.adminAction,
                              style: TextStyle(
                                  fontSize: 11, color: context.textHintColor)),
                          const Spacer(),
                          OutlinedButton(
                            onPressed: () =>
                                _updateStatus(AppConstants.statusRejected),
                            style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.error,
                                side:
                                    const BorderSide(color: AppColors.error),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                minimumSize: Size.zero,
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap),
                            child: Text(l10n.reject,
                                style: const TextStyle(fontSize: 13)),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () =>
                                _updateStatus(AppConstants.statusApproved),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.success,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                minimumSize: Size.zero,
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap),
                            child: Text(l10n.approve,
                                style: const TextStyle(fontSize: 13)),
                          ),
                        ],
                      ),
              ),
            ],

            // ── Pending notice for non-admin members ──
            if (isPending && !widget.isAdmin) ...[
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.hourglass_top_rounded,
                        size: 14, color: AppColors.warning),
                    const SizedBox(width: 8),
                    Text(
                      l10n.awaitingApproval,
                      style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.warning,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],

            if (!isPending &&
                loan.status != AppConstants.statusApproved)
              const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}

class _LoanStat extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;
  const _LoanStat({required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 3),
        Text(value,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: color)),
      ],
    );
  }
}

// ─── Payouts Tab ───
class _PayoutsTab extends ConsumerWidget {
  final GroupModel group;
  const _PayoutsTab({required this.group});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membersAsync = ref.watch(groupMembersProvider(group.id));

    return membersAsync.when(
      loading: () => const LoadingWidget(),
      error: (_, __) => _buildList(context, {}),
      data: (members) {
        final nameMap = {for (final m in members) m.id: m.fullName};
        return _buildList(context, nameMap);
      },
    );
  }

  Widget _buildList(BuildContext context, Map<String, String> nameMap) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.payoutRotation, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          ...group.payoutOrder.asMap().entries.map((e) {
            final idx = e.key;
            final memberId = e.value;
            final isDone = idx < group.currentPayoutIndex;
            final isCurrent = idx == group.currentPayoutIndex;
            final name = nameMap[memberId] ?? 'Member ${idx + 1}';

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isCurrent ? context.primarySurf : context.cardSurface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isCurrent ? AppColors.primary : context.borderColor,
                  width: isCurrent ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: isDone
                          ? AppColors.success
                          : isCurrent
                              ? AppColors.primary
                              : context.surfaceVar,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isDone ? Icons.check_rounded : Icons.circle,
                      color: isDone || isCurrent ? Colors.white : context.textHintColor,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Round ${idx + 1}',
                            style: Theme.of(context).textTheme.labelSmall),
                        Text(name,
                            style: Theme.of(context).textTheme.titleSmall),
                      ],
                    ),
                  ),
                  if (isCurrent)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(l10n.nextLabel,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700)),
                    ),
                  if (isDone)
                    Text(l10n.paidLabel,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: AppColors.success)),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

// ─── Announcements Tab ───────────────────────────────────────────────────────
class _AnnouncementsTab extends ConsumerWidget {
  final GroupModel group;
  final bool isAdmin;
  const _AnnouncementsTab({required this.group, required this.isAdmin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentUser = ref.watch(currentUserProvider).valueOrNull;
    final broadcastsAsync = ref.watch(groupBroadcastsProvider(group.id));

    return broadcastsAsync.when(
      loading: () => const LoadingWidget(),
      error: (e, _) => Center(child: Text(e.toString())),
      data: (broadcasts) {
        return CustomScrollView(
          slivers: [
            // Admin send-announcement CTA
            if (isAdmin)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        context.push('/groups/${group.id}/announce'),
                    icon: const Icon(Icons.campaign_rounded),
                    label: Text(l10n.sendAnnouncement),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),

            if (broadcasts.isEmpty)
              SliverFillRemaining(
                child: EmptyState(
                  icon: Icons.campaign_outlined,
                  title: l10n.noAnnouncements,
                  subtitle: isAdmin
                      ? l10n.noAnnouncementsSubtitle
                      : l10n.noAnnouncements,
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => _BroadcastCard(
                      broadcast: broadcasts[i],
                      currentUserId: currentUser?.id ?? '',
                      isAdmin: isAdmin,
                    ),
                    childCount: broadcasts.length,
                  ),
                ),
              ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
          ],
        );
      },
    );
  }
}

const _kEmojis = ['👍', '❤️', '😮', '😂'];

class _BroadcastCard extends ConsumerStatefulWidget {
  final GroupBroadcast broadcast;
  final String currentUserId;
  final bool isAdmin;

  const _BroadcastCard({
    required this.broadcast,
    required this.currentUserId,
    required this.isAdmin,
  });

  @override
  ConsumerState<_BroadcastCard> createState() => _BroadcastCardState();
}

class _BroadcastCardState extends ConsumerState<_BroadcastCard> {
  bool _reacting = false;

  Future<void> _react(String emoji) async {
    if (_reacting) return;
    setState(() => _reacting = true);
    try {
      await ref.read(groupServiceProvider).reactToBroadcast(
            broadcastId: widget.broadcast.id,
            userId: widget.currentUserId,
            emoji: emoji,
          );
    } finally {
      if (mounted) setState(() => _reacting = false);
    }
  }

  void _showReactions(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final reactions = widget.broadcast.reactions;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.reactionsTitle,
                  style: Theme.of(ctx).textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(l10n.reactionCount(reactions.length),
                  style: Theme.of(ctx).textTheme.bodySmall),
              const SizedBox(height: 16),
              if (reactions.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(l10n.noReactionsYet,
                        style: Theme.of(ctx).textTheme.bodyMedium),
                  ),
                )
              else
                ...reactions.entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Text(e.value,
                            style: const TextStyle(fontSize: 24)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FutureBuilder<List<UserModel>>(
                            future: ref
                                .read(groupServiceProvider)
                                .getUsersByIds([e.key]),
                            builder: (_, snap) {
                              final name = snap.data?.firstOrNull
                                      ?.fullName ??
                                  '...';
                              return Text(name,
                                  style: Theme.of(ctx)
                                      .textTheme
                                      .titleSmall);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final broadcast = widget.broadcast;
    final myEmoji = broadcast.reactions[widget.currentUserId];

    // Reaction summary: emoji → count
    final summary = <String, int>{};
    for (final e in broadcast.reactions.values) {
      summary[e] = (summary[e] ?? 0) + 1;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: context.cardSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: context.primarySurf,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                const Icon(Icons.campaign_rounded,
                    color: AppColors.primary, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(broadcast.title,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: AppColors.primary)),
                      Text(
                        l10n.broadcastFrom(broadcast.senderName),
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: context.textHintColor),
                      ),
                    ],
                  ),
                ),
                if (broadcast.createdAt != null)
                  Text(
                    _timeAgo(broadcast.createdAt!),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: context.textHintColor),
                  ),
              ],
            ),
          ),

          // Message body
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(broadcast.message,
                style: Theme.of(context).textTheme.bodyMedium),
          ),

          // Reaction summary row
          if (summary.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Wrap(
                spacing: 8,
                children: summary.entries.map((e) {
                  return GestureDetector(
                    onTap: () => _react(e.key),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: myEmoji == e.key
                            ? AppColors.primary.withOpacity(0.15)
                            : context.surfaceVar,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: myEmoji == e.key
                              ? AppColors.primary
                              : context.borderColor,
                        ),
                      ),
                      child: Text('${e.key} ${e.value}',
                          style: const TextStyle(fontSize: 13)),
                    ),
                  );
                }).toList(),
              ),
            ),

          // Action row
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 12),
            child: Row(
              children: [
                // Emoji picker
                ..._kEmojis.map((emoji) {
                  final selected = myEmoji == emoji;
                  return Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: GestureDetector(
                      onTap: _reacting ? null : () => _react(emoji),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.primary.withOpacity(0.15)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: selected
                                ? AppColors.primary
                                : Colors.transparent,
                          ),
                        ),
                        child: Text(emoji,
                            style: const TextStyle(fontSize: 20)),
                      ),
                    ),
                  );
                }),

                const Spacer(),

                // Admin: view reactions
                if (widget.isAdmin && broadcast.reactions.isNotEmpty)
                  TextButton.icon(
                    onPressed: () => _showReactions(context),
                    icon: const Icon(Icons.people_outline, size: 16),
                    label: Text(l10n.viewReactions,
                        style: const TextStyle(fontSize: 12)),
                    style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}

// ─── Join Requests Section (Admin Only) ───
class _JoinRequestsSection extends ConsumerWidget {
  final GroupModel group;
  const _JoinRequestsSection({required this.group});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final requestsAsync = ref.watch(groupJoinRequestsProvider(group.id));

    return requestsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (requests) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.cardSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: requests.isEmpty
                ? context.borderColor
                : AppColors.warning.withOpacity(0.6),
            width: requests.isEmpty ? 1 : 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.how_to_reg_rounded,
                    color: requests.isEmpty
                        ? context.textHintColor
                        : AppColors.warning,
                    size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    requests.isEmpty
                        ? l10n.noPendingRequests
                        : l10n.pendingJoinRequests(requests.length),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: requests.isEmpty
                              ? context.textHintColor
                              : AppColors.warning,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                if (requests.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.warning,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${requests.length}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
              ],
            ),
            if (requests.isEmpty) ...[
              const SizedBox(height: 6),
              Text(
                'When someone enters your invite code, their request will appear here for you to approve or reject.',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: context.textHintColor),
              ),
            ] else ...[
              const SizedBox(height: 12),
              ...requests.map((req) => _JoinRequestTile(request: req)),
            ],
          ],
        ),
      ),
    );
  }
}

class _JoinRequestTile extends ConsumerStatefulWidget {
  final JoinRequestModel request;
  const _JoinRequestTile({required this.request});

  @override
  ConsumerState<_JoinRequestTile> createState() => _JoinRequestTileState();
}

class _JoinRequestTileState extends ConsumerState<_JoinRequestTile> {
  bool _loading = false;

  Future<void> _approve() async {
    setState(() => _loading = true);
    try {
      await ref.read(groupServiceProvider).approveJoinRequest(widget.request);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  '✅ ${widget.request.userName} approved and added to the group!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        setState(() => _loading = false);
      }
    }
  }

  Future<void> _reject() async {
    setState(() => _loading = true);
    try {
      await ref
          .read(groupServiceProvider)
          .rejectJoinRequest(widget.request);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ ${widget.request.userName}\'s request rejected.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.cardSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.borderColor),
      ),
      child: Row(
        children: [
          MemberAvatar(name: widget.request.userName, size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.request.userName,
                    style: Theme.of(context).textTheme.titleSmall),
                Text(widget.request.userEmail,
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          if (_loading)
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else ...[
            IconButton(
              icon: const Icon(Icons.check_circle_rounded,
                  color: AppColors.success, size: 28),
              tooltip: 'Approve',
              onPressed: _approve,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.cancel_rounded,
                  color: AppColors.error, size: 28),
              tooltip: 'Reject',
              onPressed: _reject,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ],
      ),
    );
  }
}
