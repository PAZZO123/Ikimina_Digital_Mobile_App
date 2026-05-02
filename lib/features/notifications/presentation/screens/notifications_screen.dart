import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/group_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/app_models.dart';
import '../../../../shared/widgets/shared_widgets.dart';

// ── Provider ──
// NOTE: We intentionally do NOT use orderBy('createdAt') here because that
// requires a composite Firestore index (userId + createdAt).  Instead we
// fetch all notifications for the user and sort them in Dart.
//
// We watch currentUserProvider (not FirebaseAuth.instance.currentUser) so
// this provider re-evaluates automatically whenever the user signs in or out.
final notificationsProvider = StreamProvider<List<AppNotification>>((ref) {
  final userId = ref.watch(currentUserProvider).valueOrNull?.id;
  if (userId == null) return const Stream.empty();

  return FirebaseFirestore.instance
      .collection(AppConstants.notificationsCollection)
      .where('userId', isEqualTo: userId)
      .limit(50)
      .snapshots()
      .map((snap) {
        final list = snap.docs.map(AppNotification.fromFirestore).toList();
        // Sort newest first in Dart (avoids composite index requirement)
        list.sort((a, b) {
          final aDate = a.createdAt ?? DateTime(2000);
          final bDate = b.createdAt ?? DateTime(2000);
          return bDate.compareTo(aDate);
        });
        return list;
      })
      .handleError((_) {});
});

// ── Unread count provider (used for badge in bottom nav / app bar) ──
final unreadNotifCountProvider = Provider<int>((ref) {
  final notifs = ref.watch(notificationsProvider).valueOrNull ?? [];
  return notifs.where((n) => !n.isRead).length;
});

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  Future<void> _markAllRead(
      BuildContext context, List<AppNotification> notifs) async {
    final unread = notifs.where((n) => !n.isRead).toList();
    if (unread.isEmpty) return;
    try {
      final batch = FirebaseFirestore.instance.batch();
      for (final n in unread) {
        batch.update(
          FirebaseFirestore.instance
              .collection(AppConstants.notificationsCollection)
              .doc(n.id),
          {'isRead': true},
        );
      }
      await batch.commit();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to mark all read: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final notifAsync = ref.watch(notificationsProvider);

    return Scaffold(
      backgroundColor: context.bg,
      appBar: AppBar(
        title: Text(l10n.notifications),
        actions: [
          notifAsync.when(
            loading: () => const SizedBox(),
            error: (_, __) => const SizedBox(),
            data: (notifs) {
              final hasUnread = notifs.any((n) => !n.isRead);
              return TextButton(
                onPressed:
                    hasUnread ? () => _markAllRead(context, notifs) : null,
                child: Text(
                  l10n.markAllRead,
                  style: TextStyle(
                    color: hasUnread
                        ? AppColors.primary
                        : context.textHintColor,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: notifAsync.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (notifs) => notifs.isEmpty
            ? EmptyState(
                icon: Icons.notifications_none_rounded,
                title: l10n.noNotifications,
                subtitle: l10n.allCaughtUp,
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: notifs.length,
                itemBuilder: (_, i) => _NotifTile(notif: notifs[i])
                    .animate()
                    .fadeIn(delay: Duration(milliseconds: i * 50)),
              ),
      ),
    );
  }
}

class _NotifTile extends ConsumerStatefulWidget {
  final AppNotification notif;
  const _NotifTile({required this.notif});

  @override
  ConsumerState<_NotifTile> createState() => _NotifTileState();
}

class _NotifTileState extends ConsumerState<_NotifTile> {
  late bool _isRead;

  @override
  void initState() {
    super.initState();
    _isRead = widget.notif.isRead;
  }

  @override
  void didUpdateWidget(_NotifTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If Firestore confirms the read, sync state
    if (oldWidget.notif.isRead != widget.notif.isRead) {
      _isRead = widget.notif.isRead;
    }
  }

  IconData get _icon {
    switch (widget.notif.type) {
      case 'join_request':
        return Icons.how_to_reg_rounded;
      case 'contribution':
        return Icons.payments_rounded;
      case 'loan':
        return Icons.credit_card_rounded;
      case 'payout':
        return Icons.savings_rounded;
      case 'fine':
        return Icons.warning_rounded;
      default:
        return Icons.notifications_rounded;
    }
  }

  Color get _color {
    switch (widget.notif.type) {
      case 'join_request':
        return AppColors.warning;
      case 'contribution':
        return AppColors.success;
      case 'loan':
        return AppColors.accent;
      case 'payout':
        return AppColors.primary;
      case 'fine':
        return AppColors.error;
      default:
        return AppColors.info;
    }
  }

  Future<void> _markRead() async {
    if (_isRead) return;
    // Optimistic UI
    setState(() => _isRead = true);
    try {
      await FirebaseFirestore.instance
          .collection(AppConstants.notificationsCollection)
          .doc(widget.notif.id)
          .update({'isRead': true});
    } catch (e) {
      // Revert optimistic update on error
      if (mounted) setState(() => _isRead = false);
    }
  }

  /// Returns true when this is a personal fine notification (not a group one).
  bool get _isPersonalFine =>
      widget.notif.type == 'fine' &&
      widget.notif.title.startsWith('⚠️ You received a fine');

  void _showPayFineSheet(BuildContext context) {
    final fineId = widget.notif.actionId;
    if (fineId == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.bg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => PayFineSheet(fineId: fineId),
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat('d MMM').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = ref.watch(currentUserProvider).valueOrNull?.id ?? '';
    return GestureDetector(
      onTap: _markRead,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _isRead ? context.cardSurface : context.primarySurf,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _isRead
                ? context.borderColor
                : AppColors.primary.withOpacity(0.3),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(_icon, color: _color, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.notif.title,
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 4),
                  Text(
                    widget.notif.body,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  if (widget.notif.createdAt != null)
                    Text(
                      _timeAgo(widget.notif.createdAt!),
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: context.textHintColor),
                    ),
                  // "Pay Fine" chip for personal fine notifications
                  if (_isPersonalFine && widget.notif.actionId != null) ...[
                    const SizedBox(height: 8),
                    ActionChip(
                      label: const Text('Pay Fine'),
                      avatar: const Icon(Icons.payment_rounded, size: 16),
                      backgroundColor: AppColors.error.withOpacity(0.1),
                      labelStyle: const TextStyle(
                          color: AppColors.error, fontWeight: FontWeight.w600),
                      side: const BorderSide(color: AppColors.error),
                      onPressed: () => _showPayFineSheet(context),
                    ),
                  ],
                  // Emoji reactions for broadcast notifications
                  if (widget.notif.type == 'broadcast' &&
                      widget.notif.actionId != null) ...[
                    const SizedBox(height: 8),
                    _BroadcastReactionRow(
                      broadcastId: widget.notif.actionId!,
                      currentUserId: currentUserId,
                    ),
                  ],
                ],
              ),
            ),
            if (!_isRead)
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 4, left: 8),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Inline emoji-reaction strip shown on broadcast notifications ──────────────
const _kNotifEmojis = ['👍', '❤️', '😮', '😂'];

class _BroadcastReactionRow extends ConsumerStatefulWidget {
  final String broadcastId;
  final String currentUserId;
  const _BroadcastReactionRow(
      {required this.broadcastId, required this.currentUserId});

  @override
  ConsumerState<_BroadcastReactionRow> createState() =>
      _BroadcastReactionRowState();
}

class _BroadcastReactionRowState
    extends ConsumerState<_BroadcastReactionRow> {
  bool _reacting = false;

  Future<void> _react(String emoji) async {
    if (_reacting) return;
    setState(() => _reacting = true);
    try {
      await ref.read(groupServiceProvider).reactToBroadcast(
            broadcastId: widget.broadcastId,
            userId: widget.currentUserId,
            emoji: emoji,
          );
    } finally {
      if (mounted) setState(() => _reacting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Stream the broadcast doc for live reaction updates
    final broadcastAsync = ref.watch(
        _broadcastDocProvider(widget.broadcastId));
    final myEmoji =
        broadcastAsync.valueOrNull?.reactions[widget.currentUserId];

    return Row(
      children: _kNotifEmojis.map((emoji) {
        final selected = myEmoji == emoji;
        return Padding(
          padding: const EdgeInsets.only(right: 4),
          child: GestureDetector(
            onTap: _reacting ? null : () => _react(emoji),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.primary.withOpacity(0.15)
                    : context.surfaceVar,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: selected
                      ? AppColors.primary
                      : context.borderColor,
                ),
              ),
              child: Text(emoji, style: const TextStyle(fontSize: 16)),
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// Lightweight per-broadcast stream provider for live reaction updates.
final _broadcastDocProvider =
    StreamProvider.family<GroupBroadcast?, String>((ref, broadcastId) {
  return FirebaseFirestore.instance
      .collection(AppConstants.groupBroadcastsCollection)
      .doc(broadcastId)
      .snapshots()
      .map((snap) {
    if (!snap.exists) return null;
    return GroupBroadcast.fromFirestore(snap);
  }).handleError((_) {});
});
