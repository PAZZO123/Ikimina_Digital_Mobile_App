// ═══════════════════════════ CREATE GROUP SCREEN ═══════════════════════════
import 'package:cloud_firestore/cloud_firestore.dart';
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

class CreateGroupScreen extends ConsumerStatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  ConsumerState<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends ConsumerState<CreateGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  String _frequency = AppConstants.freqMonthly;
  DateTime _startDate = DateTime.now().add(const Duration(days: 7));
  bool _loading = false;
  // Loan rule controllers
  final _interestRateCtrl  = TextEditingController(text: '5');
  final _maxMonthsCtrl     = TextEditingController(text: '12');
  final _penaltyRateCtrl   = TextEditingController(text: '2');
  final _graceDaysCtrl     = TextEditingController(text: '7');
  final _multiplierCtrl    = TextEditingController(text: '3');
  final _minContribCtrl    = TextEditingController(text: '1');

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _amountCtrl.dispose();
    _interestRateCtrl.dispose();
    _maxMonthsCtrl.dispose();
    _penaltyRateCtrl.dispose();
    _graceDaysCtrl.dispose();
    _multiplierCtrl.dispose();
    _minContribCtrl.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      final group = await ref.read(groupServiceProvider).createGroup(
        name: _nameCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        contributionAmount: double.parse(_amountCtrl.text.replaceAll(',', '')),
        frequency: _frequency,
        startDate: _startDate,
        defaultInterestRate:  double.tryParse(_interestRateCtrl.text) ?? 5.0,
        maxRepaymentMonths:   int.tryParse(_maxMonthsCtrl.text) ?? 12,
        loanPenaltyRate:      double.tryParse(_penaltyRateCtrl.text) ?? 2.0,
        loanPenaltyGraceDays: int.tryParse(_graceDaysCtrl.text) ?? 7,
        maxLoanMultiplier:    double.tryParse(_multiplierCtrl.text) ?? 3.0,
        minContributionsForLoan: int.tryParse(_minContribCtrl.text) ?? 1,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Group created successfully!')),
        );
        context.go('/groups/${group.id}');
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
    return Scaffold(
      appBar: AppBar(title: Text(l10n.createNewGroup)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.groupDetails, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),

              AppTextField(
                controller: _nameCtrl,
                label: l10n.groupName,
                hint: 'e.g. Kigali Women\'s Ikimina',
                prefixIcon: Icons.group_rounded,
                validator: (v) => v == null || v.isEmpty ? l10n.nameRequired : null,
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: _descCtrl,
                label: l10n.groupDescription,
                hint: 'Brief description of this group',
                prefixIcon: Icons.description_outlined,
                maxLines: 3,
                validator: (v) => v == null || v.isEmpty ? l10n.descriptionRequired : null,
              ),
              const SizedBox(height: 24),

              Text(l10n.contributionRules, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),

              AppTextField(
                controller: _amountCtrl,
                label: l10n.contributionAmountRWF,
                hint: 'e.g. 50,000',
                prefixIcon: Icons.payments_outlined,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (v) {
                  if (v == null || v.isEmpty) return l10n.amountRequired;
                  final val = double.tryParse(v) ?? 0;
                  if (val < AppConstants.minContribution) {
                    return 'Min ${formatRWF(AppConstants.minContribution)}';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _frequency,
                decoration: InputDecoration(
                  labelText: l10n.contributionFrequency,
                  prefixIcon: const Icon(Icons.repeat_rounded),
                ),
                items: [
                  DropdownMenuItem(value: AppConstants.freqWeekly, child: Text(l10n.weekly)),
                  DropdownMenuItem(value: AppConstants.freqBiweekly, child: Text(l10n.biweekly)),
                  DropdownMenuItem(value: AppConstants.freqMonthly, child: Text(l10n.monthly)),
                ],
                onChanged: (v) => setState(() => _frequency = v!),
              ),
              const SizedBox(height: 16),

              // Start Date Picker
              GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _startDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) setState(() => _startDate = picked);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.surfaceVar,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: context.borderColor),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_outlined,
                          size: 20, color: context.textSec),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.startDate,
                              style: Theme.of(context).textTheme.labelSmall),
                          const SizedBox(height: 2),
                          Text(
                            DateFormat('EEEE, d MMMM yyyy').format(_startDate),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(Icons.chevron_right_rounded,
                          color: context.textHintColor),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ── Loan Rules Section ────────────────────────────────────
              Text(l10n.loanRules,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(l10n.loanRulesSubtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: context.textSec)),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(
                  child: AppTextField(
                    controller: _interestRateCtrl,
                    label: l10n.defaultInterestRate,
                    hint: '5',
                    prefixIcon: Icons.percent_rounded,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                    ],
                    validator: (v) {
                      final val = double.tryParse(v ?? '');
                      if (val == null || val < 0 || val > 100) {
                        return l10n.enterValidAmount;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppTextField(
                    controller: _maxMonthsCtrl,
                    label: l10n.maxRepaymentMonths,
                    hint: '12',
                    prefixIcon: Icons.calendar_month_outlined,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (v) {
                      final val = int.tryParse(v ?? '');
                      if (val == null || val < 1) return l10n.errorRequired;
                      return null;
                    },
                  ),
                ),
              ]),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(
                  child: AppTextField(
                    controller: _penaltyRateCtrl,
                    label: l10n.loanPenaltyRate,
                    hint: '2',
                    prefixIcon: Icons.warning_amber_rounded,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                    ],
                    validator: (v) {
                      final val = double.tryParse(v ?? '');
                      if (val == null || val < 0) return l10n.enterValidAmount;
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppTextField(
                    controller: _graceDaysCtrl,
                    label: l10n.penaltyGraceDays,
                    hint: '7',
                    prefixIcon: Icons.hourglass_bottom_rounded,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (v) {
                      final val = int.tryParse(v ?? '');
                      if (val == null || val < 0) return l10n.errorRequired;
                      return null;
                    },
                  ),
                ),
              ]),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(
                  child: AppTextField(
                    controller: _multiplierCtrl,
                    label: l10n.maxLoanMultiplier,
                    hint: '3',
                    prefixIcon: Icons.trending_up_rounded,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                    ],
                    validator: (v) {
                      final val = double.tryParse(v ?? '');
                      if (val == null || val < 1) return l10n.enterValidAmount;
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppTextField(
                    controller: _minContribCtrl,
                    label: l10n.minContributions,
                    hint: '1',
                    prefixIcon: Icons.check_circle_outline_rounded,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (v) {
                      final val = int.tryParse(v ?? '');
                      if (val == null || val < 0) return l10n.errorRequired;
                      return null;
                    },
                  ),
                ),
              ]),

              const SizedBox(height: 32),

              // Summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.primarySurf,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.info_outline, color: AppColors.primary, size: 18),
                        const SizedBox(width: 8),
                        Text(l10n.summaryLabel, style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        )),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      l10n.createGroupAdminNote,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.primaryDark),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              PrimaryButton(
                label: l10n.createGroup,
                onPressed: _create,
                isLoading: _loading,
                icon: Icons.check_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════ GROUP MEMBERS SCREEN ═══════════════════════════
class GroupMembersScreen extends ConsumerWidget {
  final String groupId;
  const GroupMembersScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final groupAsync = ref.watch(groupStreamProvider(groupId));
    final membersAsync = ref.watch(groupMembersProvider(groupId));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.groupMembersTitle)),
      body: groupAsync.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (group) {
          if (group == null) return Center(child: Text(l10n.groupNotFound));

          // Build name map from fetched user data
          final nameMap = membersAsync.maybeWhen(
            data: (users) => {for (final u in users) u.id: u.fullName},
            orElse: () => <String, String>{},
          );

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: group.memberIds.length,
            itemBuilder: (_, i) {
              final memberId = group.memberIds[i];
              final isAdmin = memberId == group.adminId;
              final payoutPos = group.payoutOrder.indexOf(memberId) + 1;
              final name = nameMap[memberId] ?? 'Member ${i + 1}';

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.cardSurface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: context.borderColor),
                ),
                child: Row(
                  children: [
                    MemberAvatar(name: name, size: 44),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(name,
                                  style: Theme.of(context).textTheme.titleSmall),
                              if (isAdmin) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: context.primarySurf,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text('Admin',
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700)),
                                ),
                              ],
                            ],
                          ),
                          Text('Payout position: #$payoutPos',
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ═══════════════════════════ ADD CONTRIBUTION SCREEN ═══════════════════════════
// ═══════════════════════ ADD CONTRIBUTION SCREEN ══════════════════════════
// Members submit a contribution request. Admins approve it in the group page.

class AddContributionScreen extends ConsumerStatefulWidget {
  final String groupId;
  final String groupName;
  const AddContributionScreen(
      {super.key, required this.groupId, required this.groupName});

  @override
  ConsumerState<AddContributionScreen> createState() =>
      _AddContributionScreenState();
}

class _AddContributionScreenState
    extends ConsumerState<AddContributionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  bool _loading = false;

  // When opened from dashboard with no groupId, member selects a group first
  String? _selectedGroupId;
  String? _selectedGroupName;

  @override
  void initState() {
    super.initState();
    if (widget.groupId.isNotEmpty) {
      _selectedGroupId = widget.groupId;
      _selectedGroupName = widget.groupName;
    }
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit(UserModel user) async {
    if (_selectedGroupId == null || _selectedGroupId!.isEmpty) return;
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      // We need the group admin to notify them
      final groupSnap = await FirebaseFirestore.instance
          .collection(AppConstants.groupsCollection)
          .doc(_selectedGroupId)
          .get();
      final adminId =
          (groupSnap.data() as Map<String, dynamic>?)?['adminId'] as String? ??
              '';

      await ref.read(groupServiceProvider).submitContributionRequest(
            groupId: _selectedGroupId!,
            groupName: _selectedGroupName ?? '',
            memberId: user.id,
            memberName: user.fullName,
            amount: double.parse(_amountCtrl.text.replaceAll(',', '')),
            note: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
            adminId: adminId,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(AppLocalizations.of(context)!.contributionRequestSent),
            backgroundColor: AppColors.success,
          ),
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
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: context.bg,
      appBar: AppBar(title: Text(l10n.submitContribution)),
      body: userAsync.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (user) {
          if (user == null) return const SizedBox();
          final groupsAsync = ref.watch(userGroupsProvider(user.id));
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info banner
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: context.primarySurf,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: AppColors.primary.withOpacity(0.25)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.info_outline_rounded,
                              color: AppColors.primary, size: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            l10n.contributionRequestInfo,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: context.textSec),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Group selector (shown when no groupId passed)
                  if (_selectedGroupId == null || _selectedGroupId!.isEmpty)
                    groupsAsync.when(
                      loading: () => const LinearProgressIndicator(),
                      error: (_, __) => const SizedBox(),
                      data: (groups) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.group_outlined),
                              labelText: l10n.selectGroup,
                            ),
                            items: groups
                                .map((g) => DropdownMenuItem(
                                      value: g.id,
                                      child: Text(g.name),
                                    ))
                                .toList(),
                            onChanged: (id) {
                              if (id == null) return;
                              final g =
                                  groups.firstWhere((x) => x.id == id);
                              setState(() {
                                _selectedGroupId = id;
                                _selectedGroupName = g.name;
                              });
                            },
                            validator: (v) =>
                                v == null ? l10n.errorRequired : null,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    )
                  else
                    // Show selected group chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.group_rounded,
                              color: AppColors.primary, size: 18),
                          const SizedBox(width: 8),
                          Text(_selectedGroupName ?? '',
                              style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),

                  // Amount field
                  AppTextField(
                    controller: _amountCtrl,
                    label: l10n.contributionAmountRWF,
                    hint: '10,000',
                    prefixIcon: Icons.payments_outlined,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[\d,]'))
                    ],
                    textInputAction: TextInputAction.next,
                    validator: (v) {
                      if (v == null || v.isEmpty) return l10n.amountRequired;
                      final n =
                          double.tryParse(v.replaceAll(',', '')) ?? 0;
                      if (n < 100) return l10n.enterValidAmount;
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Optional note
                  AppTextField(
                    controller: _noteCtrl,
                    label: l10n.notesOptional,
                    hint: 'e.g. Round 3 contribution',
                    prefixIcon: Icons.notes_rounded,
                    maxLines: 3,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 32),

                  PrimaryButton(
                    label: l10n.submitContribution,
                    isLoading: _loading,
                    icon: Icons.send_rounded,
                    onPressed: () => _submit(user),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
