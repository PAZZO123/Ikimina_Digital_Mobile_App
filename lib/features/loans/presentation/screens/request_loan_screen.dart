// ═══════════════════════ REQUEST LOAN SCREEN ═══════════════════════
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class RequestLoanScreen extends ConsumerStatefulWidget {
  final String groupId;
  const RequestLoanScreen({super.key, required this.groupId});

  @override
  ConsumerState<RequestLoanScreen> createState() => _RequestLoanScreenState();
}

class _RequestLoanScreenState extends ConsumerState<RequestLoanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  final _purposeCtrl = TextEditingController();
  int _durationMonths = 3;
  bool _loading = false;
  bool _initialized = false;

  @override
  void dispose() {
    _amountCtrl.dispose();
    _purposeCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit(GroupModel group) async {
    if (!_formKey.currentState!.validate()) return;
    final user = ref.read(currentUserProvider).valueOrNull;
    if (user == null) return;

    setState(() => _loading = true);
    try {
      await ref.read(groupServiceProvider).requestLoan(
            groupId: widget.groupId,
            borrowerId: user.id,
            borrowerName: user.fullName,
            amount: double.parse(_amountCtrl.text),
            interestRate: group.defaultInterestRate,
            durationMonths: _durationMonths,
            purpose: _purposeCtrl.text.trim(),
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(AppLocalizations.of(context)!.loanRequestSubmitted)),
        );
        context.pop();
      }
    } catch (e) {
      setState(() => _loading = false);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final groupAsync = ref.watch(groupStreamProvider(widget.groupId));
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.requestALoan)),
      body: groupAsync.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (group) {
          if (group == null) {
            return Center(child: Text(l10n.groupNotFound));
          }
          // Initialize duration to group max on first render
          if (!_initialized) {
            _durationMonths = group.maxRepaymentMonths.clamp(1, 24);
            _initialized = true;
          }
          return userAsync.when(
            loading: () => const LoadingWidget(),
            error: (e, _) => Center(child: Text(e.toString())),
            data: (user) {
              if (user == null) return const SizedBox();
              return _buildForm(context, l10n, group, user);
            },
          );
        },
      ),
    );
  }

  Widget _buildForm(BuildContext context, AppLocalizations l10n,
      GroupModel group, UserModel user) {
    final savingsAsync =
        ref.watch(memberSavingsProvider((widget.groupId, user.id)));
    final contribCountAsync =
        ref.watch(memberContributionCountProvider((widget.groupId, user.id)));

    final memberSavings = savingsAsync.valueOrNull ?? 0.0;
    final contribCount = contribCountAsync.valueOrNull ?? 0;
    final borrowingLimit = memberSavings * group.maxLoanMultiplier;
    final isEligible = contribCount >= group.minContributionsForLoan;

    final amount = double.tryParse(_amountCtrl.text) ?? 0;
    final interest = amount * group.defaultInterestRate / 100;
    final totalRepayable = amount + interest;

    // Ensure current duration doesn't exceed group max
    final maxDuration = group.maxRepaymentMonths.clamp(1, 24);
    if (_durationMonths > maxDuration) {
      _durationMonths = maxDuration;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Savings & Eligibility Banner ──────────────────────────
            _SavingsInfoBanner(
              memberSavings: memberSavings,
              borrowingLimit: borrowingLimit,
              groupBalance: group.totalBalance,
              contribCount: contribCount,
              minContribs: group.minContributionsForLoan,
              isEligible: isEligible,
            ),
            const SizedBox(height: 20),

            // ── Loan Amount ───────────────────────────────────────────
            AppTextField(
              controller: _amountCtrl,
              label: l10n.loanAmountRWF,
              hint: 'e.g. 100,000',
              prefixIcon: Icons.payments_outlined,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (_) => setState(() {}),
              validator: (v) {
                if (v == null || v.isEmpty) return l10n.amountRequired;
                final amt = double.tryParse(v) ?? 0;
                if (amt < 1000) return l10n.enterValidAmount;
                if (!isEligible) {
                  return l10n.loanEligibilityContributions(
                      group.minContributionsForLoan);
                }
                if (borrowingLimit > 0 && amt > borrowingLimit) {
                  return l10n.loanEligibilityLimit(formatRWF(borrowingLimit));
                }
                if (amt > group.totalBalance) {
                  return l10n.loanInsufficientBalance;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // ── Purpose ───────────────────────────────────────────────
            AppTextField(
              controller: _purposeCtrl,
              label: l10n.purposeOfLoan,
              hint: 'e.g. Business expansion, Medical expenses...',
              prefixIcon: Icons.description_outlined,
              maxLines: 3,
              validator: (v) =>
                  v == null || v.isEmpty ? l10n.errorRequired : null,
            ),
            const SizedBox(height: 24),

            // ── Interest Rate (locked, read-only) ─────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: context.surfaceVar,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.borderColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.lock_outline,
                      size: 18, color: context.textHintColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.interestRate,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: context.textHintColor)),
                        const SizedBox(height: 2),
                        Text(
                          '${group.defaultInterestRate.toStringAsFixed(1)}%',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          l10n.interestRateSetByGroup,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: context.textHintColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${group.defaultInterestRate.toStringAsFixed(1)}%',
                      style: const TextStyle(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w800,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ── Repayment Duration Slider ──────────────────────────────
            Text(l10n.repaymentDurationValue(_durationMonths),
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 4),
            Slider(
              value: _durationMonths
                  .toDouble()
                  .clamp(1.0, maxDuration.toDouble()),
              min: 1,
              max: maxDuration.toDouble(),
              divisions: (maxDuration - 1).clamp(1, 23),
              activeColor: AppColors.secondary,
              label: '$_durationMonths months',
              onChanged: (v) => setState(() => _durationMonths = v.toInt()),
            ),
            const SizedBox(height: 24),

            // ── Repayment Summary Card ────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.accentLight,
                borderRadius: BorderRadius.circular(14),
                border:
                    Border.all(color: AppColors.accent.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.repaymentSummary,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: AppColors.accent)),
                  const SizedBox(height: 12),
                  _RepayRow(label: l10n.principal, value: formatRWF(amount)),
                  _RepayRow(
                    label: l10n.interestWithRate(
                        group.defaultInterestRate.toStringAsFixed(1)),
                    value: formatRWF(interest),
                  ),
                  const Divider(height: 16),
                  _RepayRow(
                      label: l10n.totalToRepay,
                      value: formatRWF(totalRepayable),
                      bold: true),
                  _RepayRow(
                    label: l10n.monthlyPayment,
                    value: _durationMonths > 0
                        ? formatRWF(totalRepayable / _durationMonths)
                        : '—',
                    bold: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            PrimaryButton(
              label: l10n.submitLoanRequest,
              onPressed: isEligible ? () => _submit(group) : null,
              isLoading: _loading,
              icon: Icons.send_rounded,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────── Savings & Eligibility Banner ───────────────────────────────
class _SavingsInfoBanner extends StatelessWidget {
  final double memberSavings;
  final double borrowingLimit;
  final double groupBalance;
  final int contribCount;
  final int minContribs;
  final bool isEligible;

  const _SavingsInfoBanner({
    required this.memberSavings,
    required this.borrowingLimit,
    required this.groupBalance,
    required this.contribCount,
    required this.minContribs,
    required this.isEligible,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isEligible ? AppColors.successLight : AppColors.errorLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isEligible
              ? AppColors.success.withOpacity(0.4)
              : AppColors.error.withOpacity(0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Savings & limit row
          Row(
            children: [
              Expanded(
                child: _BannerStat(
                  icon: Icons.savings_outlined,
                  label: l10n.yourSavingsInGroup,
                  value: formatRWF(memberSavings),
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _BannerStat(
                  icon: Icons.credit_score_outlined,
                  label: l10n.yourBorrowingLimit,
                  value: formatRWF(borrowingLimit),
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Group balance
          Row(
            children: [
              Icon(
                isEligible ? Icons.check_circle_outline : Icons.info_outline,
                size: 16,
                color: isEligible ? AppColors.success : AppColors.error,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isEligible
                      ? '${l10n.availableBalance}: ${formatRWF(groupBalance)} · ${l10n.minContributions}: $contribCount/$minContribs ✓'
                      : l10n.loanEligibilityContributions(minContribs),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isEligible
                            ? AppColors.success
                            : AppColors.error,
                        fontWeight: FontWeight.w500,
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

class _BannerStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _BannerStat(
      {required this.icon,
      required this.label,
      required this.value,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: context.textHintColor)),
              const SizedBox(height: 2),
              Text(value,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700, color: color)),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────── Repay Row ──────────────────────────────────────────────────
class _RepayRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  const _RepayRow(
      {required this.label, required this.value, this.bold = false});

  @override
  Widget build(BuildContext context) {
    final style = bold
        ? Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: context.textPrim)
        : Theme.of(context).textTheme.bodySmall;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style?.copyWith(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
