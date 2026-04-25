import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/app_constants.dart';
import '../../shared/models/app_models.dart';

class NotificationService {
  static final _fcm = FirebaseMessaging.instance;
  static final _localNotifications = FlutterLocalNotificationsPlugin();

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

  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

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
      payload: message.data['route'],
    );

    // Save to Firestore
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

  static void _handleNotificationOpened(RemoteMessage message) {
    // Navigate based on data
    final route = message.data['route'];
    if (route != null) {
      // Use GoRouter to navigate — handled by main app
    }
  }

  static void _onNotificationTapped(NotificationResponse response) {
    final route = response.payload;
    if (route != null) {
      // Navigate to route
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
