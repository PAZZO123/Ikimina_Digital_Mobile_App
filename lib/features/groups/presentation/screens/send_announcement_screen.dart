// ═══════════════════════ SEND ANNOUNCEMENT SCREEN ═══════════════════════
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/group_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/app_models.dart';
import '../../../../shared/widgets/shared_widgets.dart';

class SendAnnouncementScreen extends ConsumerStatefulWidget {
  final String groupId;
  const SendAnnouncementScreen({super.key, required this.groupId});

  @override
  ConsumerState<SendAnnouncementScreen> createState() =>
      _SendAnnouncementScreenState();
}

class _SendAnnouncementScreenState
    extends ConsumerState<SendAnnouncementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  Future<void> _send(GroupModel group) async {
    if (!_formKey.currentState!.validate()) return;
    final user = ref.read(currentUserProvider).valueOrNull;
    if (user == null) return;

    setState(() => _loading = true);
    try {
      await ref.read(groupServiceProvider).sendBroadcast(
            groupId: group.id,
            groupName: group.name,
            title: _titleCtrl.text.trim(),
            message: _msgCtrl.text.trim(),
            senderId: user.id,
            senderName: user.fullName,
            memberIds: group.memberIds,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                AppLocalizations.of(context)!.sendAnnouncementSuccess),
            backgroundColor: AppColors.success,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final groupAsync = ref.watch(groupStreamProvider(widget.groupId));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.sendAnnouncement)),
      body: groupAsync.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (group) {
          if (group == null) {
            return Center(child: Text(l10n.groupNotFound));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipients banner
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: context.primarySurf,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: AppColors.primary.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.campaign_rounded,
                            color: AppColors.primary, size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(group.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                          color: AppColors.primary)),
                              Text(
                                '${group.memberIds.length} ${l10n.members}',
                                style:
                                    Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Title field
                  AppTextField(
                    controller: _titleCtrl,
                    label: l10n.announcementTitle,
                    hint: 'e.g. Meeting this Saturday',
                    prefixIcon: Icons.title_rounded,
                    textInputAction: TextInputAction.next,
                    validator: (v) =>
                        v == null || v.trim().isEmpty
                            ? l10n.titleRequired
                            : null,
                  ),
                  const SizedBox(height: 16),

                  // Message field
                  AppTextField(
                    controller: _msgCtrl,
                    label: l10n.announcementMessage,
                    hint: l10n.announcementHint,
                    prefixIcon: Icons.message_outlined,
                    maxLines: 5,
                    textInputAction: TextInputAction.done,
                    validator: (v) =>
                        v == null || v.trim().isEmpty
                            ? l10n.messageRequired
                            : null,
                  ),
                  const SizedBox(height: 32),

                  PrimaryButton(
                    label: l10n.sendAnnouncement,
                    onPressed: () => _send(group),
                    isLoading: _loading,
                    icon: Icons.send_rounded,
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
