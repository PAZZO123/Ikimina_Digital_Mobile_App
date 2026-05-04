import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/app_constants.dart';
import '../../shared/models/app_models.dart';

class NotificationService {
  static final _fcm = FirebaseMessaging.instance;
  static final _localNotifications = FlutterLocalNotificationsPlugin();

  /// Emits a GoRouter path whenever the user taps a notification.
  /// Listen to this from [IkiminaApp] and call `router.go(route)`.
  static final navigationStream = StreamController<String>.broadcast();

  static const _channelId = 'ikimina_notifications';
  static const _channelName = 'Ikimina Notifications';
  static const _channelDesc = 'Notifications for Ikimina Digital app';

  static Future<void> initialize() async {
    // Android channel
    const androidChannel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDesc,
      importance: Importance.high,
      enableVibration: true,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    // Init local notifications
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@drawable/ic_notification'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // FCM foreground handler
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // FCM background/opened handler
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationOpened);

    // Check for initial message (app opened from terminated via notification)
    final initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationOpened(initialMessage);
    }
  }

  static Future<String?> getToken() => _fcm.getToken();

  /// Build a GoRouter path from the FCM data payload.
  ///
  /// Priority:
  ///   1. explicit `route` key (set by the Cloud Function if desired)
  ///   2. derive from `type` + `groupId` / `loanId` fields
  ///   3. fall back to /notifications
  static String _routeFromData(Map<String, dynamic> data) {
    if (data['route'] case final String r when r.isNotEmpty) return r;

    final type = data['type'] ?? '';
    final groupId = data['groupId'] ?? '';
    final loanId = data['loanId'] ?? '';

    if (loanId.isNotEmpty &&
        (type == 'loan_approved' ||
            type == 'loan_rejected' ||
            type == 'loan_repayment')) {
      return '/loans/$loanId';
    }

    if (groupId.isNotEmpty) {
      return '/groups/$groupId';
    }

    return AppRoutes.notifications;
  }

  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    final route = _routeFromData(message.data);

    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@drawable/ic_notification',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: route,
    );

    // Save to Firestore only if the Cloud Function hasn't already done it.
    // The Cloud Function writes the notification document, which triggers FCM.
    // The app saves a local copy when it receives the push — skip to avoid
    // duplicates; only save if the notification arrived without a notifId.
    final hasCloudNotif = message.data['notifId']?.isNotEmpty ?? false;
    if (!hasCloudNotif) {
      final userId = message.data['userId'];
      if (userId != null) {
        await _saveNotification(
          userId: userId,
          title: notification.title ?? '',
          body: notification.body ?? '',
          type: message.data['type'] ?? 'general',
          groupId: message.data['groupId'],
          actionId: message.data['actionId'],
        );
      }
    }
  }

  static void _handleNotificationOpened(RemoteMessage message) {
    final route = _routeFromData(message.data);
    navigationStream.add(route);
  }

  static void _onNotificationTapped(NotificationResponse response) {
    final route = response.payload;
    if (route != null && route.isNotEmpty) {
      navigationStream.add(route);
    }
  }

  static Future<void> _saveNotification({
    required String userId,
    required String title,
    required String body,
    required String type,
    String? groupId,
    String? actionId,
  }) async {
    final notif = AppNotification(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      title: title,
      body: body,
      type: type,
      groupId: groupId,
      actionId: actionId,
      createdAt: DateTime.now(),
    );

    await FirebaseFirestore.instance
        .collection(AppConstants.notificationsCollection)
        .add(notif.toJson());
  }

  // ─── Send contribution reminder ───
  static Future<void> sendContributionReminder({
    required String groupName,
    required String userId,
    required double amount,
  }) async {
    await _saveNotification(
      userId: userId,
      title: 'Contribution Reminder 💰',
      body: 'Your ${formatRWF(amount)} contribution to "$groupName" is due soon.',
      type: 'contribution',
    );
  }

  // ─── Send loan status update ───
  static Future<void> sendLoanStatusUpdate({
    required String userId,
    required String status,
    required double amount,
  }) async {
    final isApproved = status == AppConstants.statusApproved;
    await _saveNotification(
      userId: userId,
      title: isApproved ? 'Loan Approved! ✅' : 'Loan Rejected ❌',
      body: isApproved
          ? 'Your loan request of ${formatRWF(amount)} has been approved.'
          : 'Your loan request of ${formatRWF(amount)} was not approved.',
      type: 'loan',
    );
  }

  // ─── Send payout notification ───
  static Future<void> sendPayoutNotification({
    required String userId,
    required String groupName,
    required double amount,
  }) async {
    await _saveNotification(
      userId: userId,
      title: 'Payout Coming! 🎉',
      body: 'You are next to receive ${formatRWF(amount)} from "$groupName".',
      type: 'payout',
    );
  }
}

String formatRWF(double v) => 'RWF ${v.round().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';
