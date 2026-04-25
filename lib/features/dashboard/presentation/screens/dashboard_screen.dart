import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/group_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/app_models.dart';
import '../../../../shared/widgets/shared_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../notifications/presentation/screens/notifications_screen.dart';

/// Streams the total approved contributions for a member across ALL their groups.
final _myTotalContribProvider =
    StreamProvider.family<double, String>((ref, memberId) {
  return FirebaseFirestore.instance
      .collection(AppConstants.contributionsCollection)
      .where('memberId', isEqualTo: memberId)
      .where('status', isEqualTo: 'completed')
      .snapshots()
      .map((snap) => snap.docs.fold<double>(
            0.0,
            (sum, doc) =>
                sum +
                ((doc.data()['amount'] as num?)?.toDouble() ?? 0.0),
          ));
});

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: context.bg,
      body: userAsync.when(
        loading: () => LoadingWidget(message: AppLocalizations.of(context)!.loadingDashboard),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (user) {
          if (user == null) return const SizedBox();
          return _DashboardContent(user: user);
        },
      ),
    );
  }
}

class _DashboardContent extends ConsumerWidget {
  final UserModel user;
  const _DashboardContent({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsAsync = ref.watch(userGroupsProvider(user.id));
    final myContrib =
        ref.watch(_myTotalContribProvider(user.id)).valueOrNull ?? 0.0;

    return CustomScrollView(
      slivers: [
        // App Bar
        SliverAppBar(
          backgroundColor: context.cardSurface,
          floating: true,
          snap: true,
          elevation: 0,
          title: Row(
            children: [
              MemberAvatar(name: user.fullName, size: 36),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Muraho, ${user.fullName.split(' ').first}! 👋',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    DateFormat('EEEE, d MMM').format(DateTime.now()),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ],
          ),
          actions: [
            // Notification bell with unread badge
            _NotifBell(),
          ],
        ),

        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: groupsAsync.when(
            loading: () => const SliverToBoxAdapter(child: LoadingWidget()),
            error: (e, _) => SliverToBoxAdapter(child: Text(e.toString())),
            data: (groups) => SliverList(
              delegate: SliverChildListDelegate([
                _buildSummaryCard(context, groups, myContrib),
                const SizedBox(height: 24),
                _buildQuickActions(context),
                const SizedBox(height: 24),
                _buildContributionChart(context, groups),
                const SizedBox(height: 24),
                _buildGroupsList(context, groups),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
      BuildContext context, List<GroupModel> groups, double myContrib) {
    final l10n = AppLocalizations.of(context)!;
    final totalGroupBalance =
        groups.fold(0.0, (s, g) => s + g.totalBalance);

    return BalanceCard(
      title: l10n.totalBalanceAllGroups,
      amount: totalGroupBalance,
      gradient: AppColors.primaryGradient,
      bottom: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.myTotalContributions,
                    style: const TextStyle(
                        color: Colors.white70, fontSize: 11)),
                const SizedBox(height: 2),
                Text(
                  formatCompact(myContrib),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Container(width: 1, height: 32, color: Colors.white24),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.activeGroups,
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 11)),
                  const SizedBox(height: 2),
                  Text(
                    '${groups.length}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.2);
  }

  Widget _buildQuickActions(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final actions = [
      _QuickAction(
        icon: Icons.add_circle_outline_rounded,
        label: l10n.newGroup,
        color: AppColors.primary,
        onTap: () => context.push('/groups/create'),
      ),
      _QuickAction(
        icon: Icons.qr_code_scanner_rounded,
        label: l10n.joinGroup,
        color: AppColors.secondary,
        onTap: () => _showJoinDialog(context),
      ),
      _QuickAction(
        icon: Icons.payment_rounded,
        label: l10n.contribute,
        color: AppColors.accent,
        onTap: () => context.push('/contributions/add',
            extra: {'groupId': '', 'groupName': ''}),
      ),
      _QuickAction(
        icon: Icons.picture_as_pdf_outlined,
        label: l10n.reports,
        color: AppColors.info,
        onTap: () => context.push(AppRoutes.reports),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.quickActions, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Row(
          children: actions
              .map((a) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: _QuickActionCard(action: a),
                    ),
                  ))
              .toList(),
        ),
      ],
    ).animate().fadeIn(delay: 100.ms);
  }

  Widget _buildContributionChart(BuildContext context, List<GroupModel> groups) {
    final l10n = AppLocalizations.of(context)!;
    if (groups.isEmpty) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.cardSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.groupBalanceOverview,
                  style: Theme.of(context).textTheme.titleMedium),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: context.primarySurf,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(l10n.allGroupsLabel,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: AppColors.primary)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 180,
            child: groups.isEmpty
                ? Center(child: Text(l10n.noData))
                : BarChart(
                    BarChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 50000,
                        getDrawingHorizontalLine: (_) => FlLine(
                          color: AppColors.divider,
                          strokeWidth: 1,
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (val, meta) {
                              final i = val.toInt();
                              if (i >= groups.length) return const SizedBox();
                              return Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  groups[i].name.length > 8
                                      ? '${groups[i].name.substring(0, 7)}…'
                                      : groups[i].name,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 60,
                            getTitlesWidget: (val, meta) => Text(
                              formatCompact(val),
                              style: TextStyle(
                                  fontSize: 10, color: context.textHintColor),
                            ),
                          ),
                        ),
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      barGroups: groups.asMap().entries.map((e) {
                        return BarChartGroupData(
                          x: e.key,
                          barRods: [
                            BarChartRodData(
                              toY: e.value.totalBalance,
                              color: AppColors.primary,
                              width: 20,
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(6)),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildGroupsList(BuildContext context, List<GroupModel> groups) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context)!.myGroups, style: Theme.of(context).textTheme.titleLarge),
            TextButton(
              onPressed: () {},
              child: Text(AppLocalizations.of(context)!.seeAll),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (groups.isEmpty)
          EmptyState(
            icon: Icons.group_outlined,
            title: AppLocalizations.of(context)!.noGroups,
            subtitle: 'Create or join an Ikimina group to get started',
            action: ElevatedButton(
              onPressed: () => context.push('/groups/create'),
              child: Text(AppLocalizations.of(context)!.createGroup),
            ),
          )
        else
          ...groups.take(5).map((g) => _GroupListTile(group: g)),
      ],
    ).animate().fadeIn(delay: 300.ms);
  }

  void _showJoinDialog(BuildContext context) {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Join a Group'),
        content: TextField(
          controller: ctrl,
          textCapitalization: TextCapitalization.characters,
          decoration: const InputDecoration(
            labelText: 'Invite Code',
            hintText: 'e.g. ABC123',
            prefixIcon: Icon(Icons.qr_code_rounded),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              // join logic via provider
            },
            child: const Text('Join'),
          ),
        ],
      ),
    );
  }
}

class _QuickAction {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _QuickAction(
      {required this.icon,
      required this.label,
      required this.color,
      required this.onTap});
}

class _QuickActionCard extends StatelessWidget {
  final _QuickAction action;
  const _QuickActionCard({required this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: action.color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: action.color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(action.icon, color: action.color, size: 26),
            const SizedBox(height: 8),
            Text(action.label,
                style: TextStyle(
                    color: action.color,
                    fontSize: 11,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

// ── Notification Bell with unread badge ──
class _NotifBell extends ConsumerWidget {
  const _NotifBell();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCount = ref.watch(unreadNotifCountProvider);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: Icon(
            unreadCount > 0
                ? Icons.notifications_rounded
                : Icons.notifications_outlined,
          ),
          onPressed: () => context.push(AppRoutes.notifications),
        ),
        if (unreadCount > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                unreadCount > 9 ? '9+' : '$unreadCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

class _GroupListTile extends StatelessWidget {
  final GroupModel group;
  const _GroupListTile({required this.group});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/groups/${group.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.cardSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.borderColor),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.savings_rounded,
                  color: Colors.white, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(group.name,
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 2),
                  Text(
                    '${group.memberIds.length} members · ${formatRWF(group.contributionAmount)}/round',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(formatCompact(group.totalBalance),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: AppColors.primary)),
                const SizedBox(height: 4),
                StatusBadge(group.status),
              ],
            ),
          ],
        ),
      ),
    );
  }
}