// ═══════════════════════ LOAN DETAIL SCREEN ═══════════════════════════
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/group_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/app_models.dart';
import '../../../../shared/widgets/shared_widgets.dart';

// ── providers ──────────────────────────────────────────────────────────────
final _loanDetailProvider =
    StreamProvider.family<LoanModel?, String>((ref, loanId) {
  return FirebaseFirestore.instance
      .collection(AppConstants.loansCollection)
      .doc(loanId)
      .snapshots()
      .map((s) => s.exists ? LoanModel.fromFirestore(s) : null);
});

final _pendingRepaymentProvider =
    StreamProvider.family<List<RepaymentRequest>, String>((ref, loanId) {
  return FirebaseFirestore.instance
      .collection(AppConstants.repaymentRequestsCollection)
      .where('loanId', isEqualTo: loanId)
      .where('status', isEqualTo: 'pending')
      .snapshots()
      .map((s) => s.docs.map(RepaymentRequest.fromFirestore).toList());
});

// ── Screen ─────────────────────────────────────────────────────────────────
class LoanDetailScreen extends ConsumerWidget {
  final String loanId;
  const LoanDetailScreen({super.key, required this.loanId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loanAsync = ref.watch(_loanDetailProvider(loanId));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: context.bg,
      appBar: AppBar(title: Text(l10n.loanDetails)),
      body: loanAsync.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (loan) {
          if (loan == null) {
            return Center(child: Text(l10n.groupNotFound));
          }
          return _LoanDetailContent(loan: loan);
        },
      ),
    );
  }
}

class _LoanDetailContent extends ConsumerWidget {
  final LoanModel loan;
  const _LoanDetailContent({required this.loan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentUser = ref.watch(currentUserProvider).valueOrNull;
    final groupAsync = ref.watch(groupStreamProvider(loan.groupId));
    final pendingAsync =
        ref.watch(_pendingRepaymentProvider(loan.id));
    final isOwner = currentUser?.id == loan.borrowerId;
    final hasPendingRepayment =
        pendingAsync.valueOrNull?.isNotEmpty ?? false;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status header card
          _StatusCard(loan: loan),
          const SizedBox(height: 20),

          // Repayment progress
          _RepaymentProgressCard(loan: loan),
          const SizedBox(height: 20),

          // Loan details
          _DetailCard(loan: loan),
          const SizedBox(height: 20),

          // Pending repayment notice
          if (hasPendingRepayment) ...[
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: context.warningSurf,
                borderRadius: BorderRadius.circular(14),
                border:
                    Border.all(color: AppColors.warning.withOpacity(0.4)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.hourglass_top_rounded,
                      color: AppColors.warning, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      l10n.repaymentPending,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.warning),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],

          // Repayment button — member submits request
          if (isOwner &&
              loan.status == 'approved' &&
              !loan.isFullyRepaid &&
              !hasPendingRepayment)
            groupAsync.when(
              loading: () => const SizedBox(),
              error: (_, __) => const SizedBox(),
              data: (group) {
                if (group == null) return const SizedBox();
                return _RepaymentRequestButton(
                    loan: loan, group: group, user: currentUser!);
              },
            ),
        ],
      ),
    );
  }
}

// ── Status card ────────────────────────────────────────────────────────────
class _StatusCard extends StatelessWidget {
  final LoanModel loan;
  const _StatusCard({required this.loan});

  @override
  Widget build(BuildContext context) {
    final color = loan.isOverdue
        ? AppColors.error
        : loan.status == 'approved'
            ? AppColors.success
            : loan.status == 'completed'
                ? AppColors.info
                : AppColors.warning;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.75)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.credit_card_rounded,
                  color: Colors.white, size: 22),
              const SizedBox(width: 8),
              Text(loan.borrowerName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  loan.isOverdue
                      ? 'OVERDUE'
                      : loan.status.toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            formatRWF(loan.amount),
            style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            loan.purpose ?? AppLocalizations.of(context)!.noPurpose,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

// ── Repayment progress card ────────────────────────────────────────────────
class _RepaymentProgressCard extends StatelessWidget {
  final LoanModel loan;
  const _RepaymentProgressCard({required this.loan});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final progress =
        loan.totalDue > 0 ? (loan.amountRepaid / loan.totalDue).clamp(0.0, 1.0) : 0.0;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.cardSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.repaymentSummary,
              style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _AmountRow(label: l10n.principal, amount: loan.amount),
              _AmountRow(
                  label: l10n.totalToRepay, amount: loan.totalDue),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _AmountRow(
                  label: 'Repaid',
                  amount: loan.amountRepaid,
                  color: AppColors.success),
              _AmountRow(
                  label: 'Remaining',
                  amount: loan.remainingBalance,
                  color: AppColors.error),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: context.surfaceVar,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.success),
            ),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${(progress * 100).toStringAsFixed(0)}% ${loan.isFullyRepaid ? "✅" : ""}',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: AppColors.success),
            ),
          ),
        ],
      ),
    );
  }
}

class _AmountRow extends StatelessWidget {
  final String label;
  final double amount;
  final Color? color;
  const _AmountRow({required this.label, required this.amount, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 2),
        Text(
          formatRWF(amount),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: color ?? context.textPrim,
          ),
        ),
      ],
    );
  }
}

// ── Detail card ────────────────────────────────────────────────────────────
class _DetailCard extends StatelessWidget {
  final LoanModel loan;
  const _DetailCard({required this.loan});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fmt = DateFormat('d MMM yyyy');

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.cardSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.loanDetails,
              style: Theme.of(context).textTheme.titleSmall),
          const Divider(height: 20),
          _DetailRow(
            label: l10n.interestRate,
            value: '${loan.interestRate.toStringAsFixed(1)}%',
          ),
          _DetailRow(
            label: l10n.duration,
            value: '${loan.durationMonths} months',
          ),
          _DetailRow(
            label: 'Requested',
            value: fmt.format(loan.requestedAt),
          ),
          if (loan.approvedAt != null)
            _DetailRow(
              label: l10n.approve,
              value: fmt.format(loan.approvedAt!),
            ),
          if (loan.dueDate != null)
            _DetailRow(
              label: l10n.dueDate,
              value: fmt.format(loan.dueDate!),
              valueColor:
                  loan.isOverdue ? AppColors.error : null,
            ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  const _DetailRow(
      {required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: valueColor ?? context.textPrim,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Repayment request button + bottom sheet ───────────────────────────────
class _RepaymentRequestButton extends ConsumerStatefulWidget {
  final LoanModel loan;
  final GroupModel group;
  final UserModel user;
  const _RepaymentRequestButton(
      {required this.loan, required this.group, required this.user});

  @override
  ConsumerState<_RepaymentRequestButton> createState() =>
      _RepaymentRequestButtonState();
}

class _RepaymentRequestButtonState
    extends ConsumerState<_RepaymentRequestButton> {
  final _amountCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _amountCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final amount =
        double.tryParse(_amountCtrl.text.replaceAll(',', '')) ?? 0;
    if (amount <= 0) return;
    setState(() => _loading = true);
    try {
      await ref.read(groupServiceProvider).submitRepaymentRequest(
            loanId: widget.loan.id,
            groupId: widget.loan.groupId,
            memberId: widget.user.id,
            memberName: widget.user.fullName,
            amount: amount,
            adminId: widget.group.adminId,
            groupName: widget.group.name,
          );
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(AppLocalizations.of(context)!.repaymentRequestSent),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      setState(() => _loading = false);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  void _showSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.cardSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 32,
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
            Text(l10n.submitRepayment,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(
              'Remaining: ${formatRWF(widget.loan.remainingBalance)}',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 20),
            AppTextField(
              controller: _amountCtrl,
              label: l10n.amountRWF,
              hint: widget.loan.remainingBalance.toStringAsFixed(0),
              prefixIcon: Icons.payments_outlined,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d,]'))
              ],
              textInputAction: TextInputAction.done,
              validator: (v) {
                if (v == null || v.isEmpty) return l10n.amountRequired;
                final n = double.tryParse(v.replaceAll(',', '')) ?? 0;
                if (n <= 0) return l10n.enterValidAmount;
                if (n > widget.loan.remainingBalance + 1) {
                  return 'Amount exceeds remaining balance';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: l10n.submitRepayment,
              isLoading: _loading,
              icon: Icons.send_rounded,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return PrimaryButton(
      label: l10n.submitRepayment,
      icon: Icons.payment_rounded,
      onPressed: () => _showSheet(context),
    );
  }
}
