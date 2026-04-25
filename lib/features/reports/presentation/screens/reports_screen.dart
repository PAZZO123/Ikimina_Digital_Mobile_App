import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:printing/printing.dart';

import '../../../../core/services/auth_service.dart';
import '../../../../core/services/group_service.dart';
import '../../../../core/services/pdf_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/app_models.dart';
import '../../../../shared/widgets/shared_widgets.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: context.bg,
      appBar: AppBar(title: Text(l10n.financialReports)),
      body: userAsync.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (user) {
          if (user == null) return const SizedBox();
          return _ReportsContent(user: user);
        },
      ),
    );
  }
}

class _ReportsContent extends ConsumerWidget {
  final UserModel user;
  const _ReportsContent({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final groupsAsync = ref.watch(userGroupsProvider(user.id));

    return groupsAsync.when(
      loading: () => const LoadingWidget(),
      error: (e, _) => Center(child: Text(e.toString())),
      data: (groups) => groups.isEmpty
          ? EmptyState(
              icon: Icons.picture_as_pdf_outlined,
              title: l10n.noReports,
              subtitle: l10n.noReportsSubtitle,
            )
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.picture_as_pdf_rounded,
                          color: Colors.white, size: 32),
                      const SizedBox(height: 12),
                      Text(
                        l10n.pdfReports,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        l10n.pdfReportsDescription,
                        style:
                            const TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ).animate().fadeIn(),

                const SizedBox(height: 24),
                Text(l10n.myGroups,
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),

                ...groups.asMap().entries.map((e) =>
                    _GroupReportCard(
                      group: e.value,
                      ref: ref,
                      user: user,
                    ).animate().fadeIn(
                        delay: Duration(milliseconds: e.key * 100))),
              ],
            ),
    );
  }
}

class _GroupReportCard extends StatefulWidget {
  final GroupModel group;
  final WidgetRef ref;
  final UserModel user;

  const _GroupReportCard({
    required this.group,
    required this.ref,
    required this.user,
  });

  @override
  State<_GroupReportCard> createState() => _GroupReportCardState();
}

class _GroupReportCardState extends State<_GroupReportCard> {
  bool _generating = false;

  Future<void> _generateReport({bool share = false}) async {
    setState(() => _generating = true);

    try {
      final service = widget.ref.read(groupServiceProvider);

      // Fetch all data in parallel
      final results = await Future.wait([
        service.streamContributions(widget.group.id).first,
        service.streamGroupLoans(widget.group.id).first,
        service.streamGroupFines(widget.group.id).first,
        service.getUsersByIds(widget.group.memberIds),
      ]);

      final contributions = results[0] as List<ContributionModel>;
      final loans = results[1] as List<LoanModel>;
      final fines = results[2] as List<FineModel>;
      final members = results[3] as List<UserModel>;

      final file = await PdfReportService.generateGroupReport(
        group: widget.group,
        members: members.isEmpty ? [widget.user] : members,
        contributions: contributions,
        loans: loans,
        payouts: [],
        fines: fines,
      );

      if (!mounted) return;
      setState(() => _generating = false);

      if (share) {
        // Share via system share sheet
        final bytes = await file.readAsBytes();
        await Printing.sharePdf(
          bytes: Uint8List.fromList(bytes),
          filename:
              'ikimina_${widget.group.name.replaceAll(' ', '_')}_report.pdf',
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Report saved: ${file.path}'),
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: 'Share',
              onPressed: () async {
                final bytes = await file.readAsBytes();
                await Printing.sharePdf(
                  bytes: Uint8List.fromList(bytes),
                  filename:
                      'ikimina_${widget.group.name.replaceAll(' ', '_')}_report.pdf',
                );
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _generating = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
                    Text(widget.group.name,
                        style: Theme.of(context).textTheme.titleMedium),
                    Text(
                      '${widget.group.memberIds.length} members · ${widget.group.contributionFrequency}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Stats row
          Row(
            children: [
              Expanded(
                child: _MiniStat(
                  label: 'Balance',
                  value: formatCompact(widget.group.totalBalance),
                  color: AppColors.primary,
                ),
              ),
              Expanded(
                child: _MiniStat(
                  label: 'Contributed',
                  value: formatCompact(widget.group.totalContributed),
                  color: AppColors.success,
                ),
              ),
              Expanded(
                child: _MiniStat(
                  label: 'Loaned',
                  value: formatCompact(widget.group.totalLoaned),
                  color: AppColors.accent,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _generating
                      ? null
                      : () => _generateReport(share: false),
                  icon: _generating
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: AppColors.primary),
                        )
                      : const Icon(Icons.picture_as_pdf_outlined, size: 18),
                  label: Text(_generating ? l10n.generating : l10n.download),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _generating
                      ? null
                      : () => _generateReport(share: true),
                  icon: const Icon(Icons.share_outlined, size: 18),
                  label: Text(l10n.sharePDF),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MiniStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: context.textHintColor)),
        const SizedBox(height: 2),
        Text(value,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: color)),
      ],
    );
  }
}