import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/group_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/app_models.dart';
import '../../../../shared/widgets/shared_widgets.dart';

class LoansScreen extends ConsumerWidget {
  const LoansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: context.bg,
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.loans)),
      body: userAsync.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (user) {
          if (user == null) return const SizedBox();
          return _LoansContent(user: user);
        },
      ),
    );
  }
}

class _LoansContent extends ConsumerWidget {
  final UserModel user;
  const _LoansContent({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Stream all loans across user's groups
    final groupsAsync = ref.watch(userGroupsProvider(user.id));

    return groupsAsync.when(
      loading: () => const LoadingWidget(),
      error: (e, _) => Center(child: Text(e.toString())),
      data: (groups) {
        if (groups.isEmpty) {
          return EmptyState(
            icon: Icons.account_balance_wallet_outlined,
            title: AppLocalizations.of(context)!.noGroups,
            subtitle: AppLocalizations.of(context)!.joinGroupForLoans,
          );
        }

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildLoanSummaryCard(context, groups),
                    const SizedBox(height: 24),
                    _buildRequestLoanSection(context, groups),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(AppLocalizations.of(context)!.recentLoans,
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            ...groups.map((group) => SliverToBoxAdapter(
                  child: _GroupLoanSection(group: group, user: user),
                )),
            const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
          ],
        );
      },
    );
  }

  Widget _buildLoanSummaryCard(BuildContext context, List<GroupModel> groups) {
    final l10n = AppLocalizations.of(context)!;
    final totalLoaned = groups.fold(0.0, (s, g) => s + g.totalLoaned);
    final totalBalance = groups.fold(0.0, (s, g) => s + g.totalBalance);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.loanOverview,
              style: const TextStyle(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.totalLoanedOut,
                        style: const TextStyle(color: Colors.white54, fontSize: 11)),
                    const SizedBox(height: 4),
                    Text(
                      formatCompact(totalLoaned),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.availableBalance,
                        style: const TextStyle(color: Colors.white54, fontSize: 11)),
                    const SizedBox(height: 4),
                    Text(
                      formatCompact(totalBalance),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Loan vs Balance pie indicator
          if (totalLoaned + totalBalance > 0) ...[
            Text(l10n.allocation,
                style: const TextStyle(color: Colors.white70, fontSize: 11)),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: totalBalance / (totalLoaned + totalBalance),
                backgroundColor: Colors.white24,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.primary),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                _Legend(color: AppColors.primary, label: l10n.available),
                const SizedBox(width: 16),
                _Legend(color: Colors.white24, label: l10n.loanedOutLabel),
              ],
            ),
          ],
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.2);
  }

  Widget _buildRequestLoanSection(
      BuildContext context, List<GroupModel> groups) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.accentLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.accent.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.credit_card_rounded,
                color: AppColors.accent, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.needLoan,
                    style: Theme.of(context).textTheme.titleSmall),
                Text(AppLocalizations.of(context)!.borrowFromGroup,
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => context.push('/loans/request',
                extra: {'groupId': groups.first.id}),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            ),
            child: Text(l10n.requestLabel, style: const TextStyle(fontSize: 13)),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms);
  }
}

class _GroupLoanSection extends ConsumerWidget {
  final GroupModel group;
  final UserModel user;

  const _GroupLoanSection({required this.group, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loansAsync = ref.watch(groupLoansProvider(group.id));

    return loansAsync.when(
      loading: () => const SizedBox(),
      error: (_, __) => const SizedBox(),
      data: (loans) {
        if (loans.isEmpty) return const SizedBox();

        // Filter to only this user's loans if not admin
        final isAdmin = user.id == group.adminId;
        final displayLoans =
            isAdmin ? loans : loans.where((l) => l.borrowerId == user.id).toList();

        if (displayLoans.isEmpty) return const SizedBox();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(group.name,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: AppColors.primary)),
              ),
              ...displayLoans.map((loan) => _LoanCard(loan: loan)),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

class _LoanCard extends StatelessWidget {
  final LoanModel loan;
  const _LoanCard({required this.loan});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/loans/${loan.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: loan.isOverdue
              ? context.errorSurf
              : context.cardSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: loan.isOverdue
                  ? AppColors.error.withOpacity(0.4)
                  : context.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(loan.borrowerName,
                      style: Theme.of(context).textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(width: 8),
                if (loan.isOverdue)
                  Container(
                    margin: const EdgeInsets.only(right: 6),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.warning_amber_rounded,
                            size: 11, color: Colors.white),
                        const SizedBox(width: 3),
                        Text(
                          AppLocalizations.of(context)!.overdue,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                StatusBadge(loan.status),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _LoanStat(
                    label: 'Principal',
                    value: formatRWF(loan.amount),
                  ),
                ),
                Expanded(
                  child: _LoanStat(
                    label: 'Total Due',
                    value: formatRWF(loan.totalDue),
                  ),
                ),
                Expanded(
                  child: _LoanStat(
                    label: 'Interest',
                    value: '${loan.interestRate}%',
                  ),
                ),
              ],
            ),
            if (loan.status == AppConstants.statusApproved ||
                loan.status == AppConstants.statusCompleted) ...[
              const SizedBox(height: 14),
              LabeledProgress(
                label: 'Repayment Progress',
                progress: loan.repaymentProgress.clamp(0, 1),
                leftLabel: 'Paid: ${formatRWF(loan.amountRepaid)}',
                rightLabel: 'Left: ${formatRWF(loan.remainingBalance)}',
                color: loan.isFullyRepaid ? AppColors.success : AppColors.accent,
              ),
            ],
            if (loan.purpose != null && loan.purpose!.isNotEmpty) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.info_outline,
                      size: 14, color: context.textHintColor),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      loan.purpose!,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _LoanStat extends StatelessWidget {
  final String label;
  final String value;
  const _LoanStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 2),
        Text(value,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  const _Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 11)),
      ],
    );
  }
}