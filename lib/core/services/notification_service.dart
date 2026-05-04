import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import '../constants/app_constants.dart';
import '../constants/fcm_service_account.dart';
import '../../shared/models/app_models.dart';

class NotificationService {
  static final _fcm = FirebaseMessaging.instance;
  static final _localNotifications = FlutterLocalNotificationsPlugin();

  static const _channelId = 'ikimina_notifications';
  static const _channelName = 'Ikimina Notifications';
  static const _channelDesc = 'Notifications for Ikimina Digital app';

  /// Emits a GoRouter path whenever the user taps a notification.
  /// Subscribed from [IkiminaApp] in main.dart → calls router.go(route).
  static final navigationStream = StreamController<String>.broadcast();

  // ── OAuth2 token cache ──────────────────────────────────────────────────────
  static String? _cachedAccessToken;
  static DateTime? _tokenExpiry;

  // ── FCM v1 endpoint ────────────────────────────────────────────────────────
  static const _fcmUrl =
      'https://fcm.googleapis.com/v1/projects/${FcmServiceAccount.projectId}/messages:send';

  // ── init ───────────────────────────────────────────────────────────────────

  static Future<void> initialize() async {
    // Android notification channel
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

    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@drawable/ic_notification'),
      iOS: DarwinInitializationSettings(),
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // FCM handlers
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationOpened);

    final initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationOpened(initialMessage);
    }
  }

  static Future<String?> getToken() => _fcm.getToken();

  // ── Navigation helpers ─────────────────────────────────────────────────────

  /// Build a GoRouter path from the FCM data payload.
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
    if (groupId.isNotEmpty) return '/groups/$groupId';
    return AppRoutes.notifications;
  }

  // ── FCM foreground / tap handlers ──────────────────────────────────────────

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
  }

  static void _handleNotificationOpened(RemoteMessage message) {
    navigationStream.add(_routeFromData(message.data));
  }

  static void _onNotificationTapped(NotificationResponse response) {
    final route = response.payload;
    if (route != null && route.isNotEmpty) navigationStream.add(route);
  }

  // ── OAuth2 via service account JWT ─────────────────────────────────────────

  /// Returns a cached Google OAuth2 access token, refreshing if expired.
  static Future<String?> _getAccessToken() async {
    // Return cached token if still valid (with 60s buffer)
    if (_cachedAccessToken != null &&
        _tokenExpiry != null &&
        DateTime.now().isBefore(_tokenExpiry!.subtract(const Duration(seconds: 60)))) {
      return _cachedAccessToken;
    }

    // Guard: placeholder not replaced yet
    if (FcmServiceAccount.privateKey.contains('REPLACE_WITH_YOUR_PRIVATE_KEY')) {
      return null;
    }

    try {
      final now = DateTime.now().toUtc();
      final jwt = JWT(
        {
          'iss': FcmServiceAccount.clientEmail,
          'scope': 'https://www.googleapis.com/auth/firebase.messaging',
          'aud': 'https://oauth2.googleapis.com/token',
          'iat': now.millisecondsSinceEpoch ~/ 1000,
          'exp': (now.millisecondsSinceEpoch ~/ 1000) + 3600,
        },
      );

      final signedJwt = jwt.sign(
        RSAPrivateKey(FcmServiceAccount.privateKey),
        algorithm: JWTAlgorithm.RS256,
      );

      final response = await http.post(
        Uri.parse('https://oauth2.googleapis.com/token'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'grant_type': 'urn:ietf:params:oauth:grant-type:jwt-bearer',
          'assertion': signedJwt,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        _cachedAccessToken = data['access_token'] as String;
        _tokenExpiry = now.add(Duration(seconds: (data['expires_in'] as int? ?? 3600)));
        return _cachedAccessToken;
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  // ── Direct FCM v1 send ─────────────────────────────────────────────────────

  /// Sends an FCM push directly to [fcmToken] using the service account.
  /// No Cloud Functions, no Blaze plan — works 100% free.
  static Future<void> _sendFcmToToken({
    required String fcmToken,
    required String title,
    required String body,
    required Map<String, String> data,
  }) async {
    final accessToken = await _getAccessToken();
    if (accessToken == null) return; // service account not configured yet

    final payload = {
      'message': {
        'token': fcmToken,
        'notification': {'title': title, 'body': body},
        'data': data,
        'android': {
          'priority': 'high',
          'notification': {'channel_id': _channelId, 'sound': 'default'},
        },
        'apns': {
          'payload': {
            'aps': {'sound': 'default', 'badge': 1},
          },
        },
      },
    };

    try {
      await http.post(
        Uri.parse(_fcmUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );
    } catch (_) {
      // Silently fail — in-app Firestore notifications still work
    }
  }

  /// Public version — called by GroupService so every in-app notification also
  /// delivers a real FCM push without needing Cloud Functions.
  static Future<void> pushToUser({
    required String userId,
    required String title,
    required String body,
    String type = 'general',
    String? groupId,
    String? loanId,
  }) => _pushToUser(userId: userId, title: title, body: body, type: type, groupId: groupId, loanId: loanId);

  /// Looks up [userId]'s FCM token from Firestore and sends them a push.
  static Future<void> _pushToUser({
    required String userId,
    required String title,
    required String body,
    String type = 'general',
    String? groupId,
    String? loanId,
  }) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .get();
      final token = userDoc.data()?['fcmToken'] as String?;
      if (token == null || token.isEmpty) return;

      await _sendFcmToToken(
        fcmToken: token,
        title: title,
        body: body,
        data: {
          'type': type,
          if (groupId != null) 'groupId': groupId,
          if (loanId != null) 'loanId': loanId,
        },
      );
    } catch (_) {
      // FCM push failed — Firestore notification is still saved
    }
  }

  // ── Firestore notification writer ──────────────────────────────────────────

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

  // ── Public notification senders ────────────────────────────────────────────
  //
  // Each method:
  //   1. Writes the notification to Firestore (shows in bell / notification screen)
  //   2. Sends a real FCM push to the recipient's device (works offline / background)

  static Future<void> sendContributionReminder({
    required String groupName,
    required String userId,
    required double amount,
    String? groupId,
  }) async {
    const title = 'Contribution Reminder 💰';
    final body = 'Your ${formatRWF(amount)} contribution to "$groupName" is due soon.';
    await Future.wait([
      _saveNotification(userId: userId, title: title, body: body, type: 'contribution', groupId: groupId),
      _pushToUser(userId: userId, title: title, body: body, type: 'contribution', groupId: groupId),
    ]);
  }

  static Future<void> sendContributionApproved({
    required String userId,
    required double amount,
    required String groupName,
    String? groupId,
  }) async {
    const title = 'Contribution Approved ✅';
    final body = 'Your ${formatRWF(amount)} contribution to "$groupName" has been approved.';
    await Future.wait([
      _saveNotification(userId: userId, title: title, body: body, type: 'contribution_approved', groupId: groupId),
      _pushToUser(userId: userId, title: title, body: body, type: 'contribution_approved', groupId: groupId),
    ]);
  }

  static Future<void> sendContributionRejected({
    required String userId,
    required double amount,
    required String groupName,
    String? groupId,
  }) async {
    const title = 'Contribution Rejected ❌';
    final body = 'Your ${formatRWF(amount)} contribution to "$groupName" was not approved.';
    await Future.wait([
      _saveNotification(userId: userId, title: title, body: body, type: 'contribution_rejected', groupId: groupId),
      _pushToUser(userId: userId, title: title, body: body, type: 'contribution_rejected', groupId: groupId),
    ]);
  }

  static Future<void> sendLoanStatusUpdate({
    required String userId,
    required String status,
    required double amount,
    String? loanId,
    String? groupId,
  }) async {
    final isApproved = status == AppConstants.statusApproved;
    final title = isApproved ? 'Loan Approved! ✅' : 'Loan Rejected ❌';
    final body = isApproved
        ? 'Your loan request of ${formatRWF(amount)} has been approved.'
        : 'Your loan request of ${formatRWF(amount)} was not approved.';
    await Future.wait([
      _saveNotification(userId: userId, title: title, body: body, type: 'loan', groupId: groupId),
      _pushToUser(userId: userId, title: title, body: body, type: isApproved ? 'loan_approved' : 'loan_rejected', groupId: groupId, loanId: loanId),
    ]);
  }

  static Future<void> sendFineNotification({
    required String userId,
    required double amount,
    required String reason,
    String? groupId,
  }) async {
    const title = 'Fine Issued ⚠️';
    final body = 'You have been fined ${formatRWF(amount)} for: $reason';
    await Future.wait([
      _saveNotification(userId: userId, title: title, body: body, type: 'fine', groupId: groupId),
      _pushToUser(userId: userId, title: title, body: body, type: 'fine', groupId: groupId),
    ]);
  }

  static Future<void> sendFinePaymentApproved({
    required String userId,
    required double amount,
    String? groupId,
  }) async {
    const title = 'Fine Payment Approved ✅';
    final body = 'Your fine payment of ${formatRWF(amount)} has been confirmed.';
    await Future.wait([
      _saveNotification(userId: userId, title: title, body: body, type: 'fine_approved', groupId: groupId),
      _pushToUser(userId: userId, title: title, body: body, type: 'fine_approved', groupId: groupId),
    ]);
  }

  static Future<void> sendRepaymentApproved({
    required String userId,
    required double amount,
    String? groupId,
    String? loanId,
  }) async {
    const title = 'Repayment Confirmed ✅';
    final body = 'Your loan repayment of ${formatRWF(amount)} has been approved.';
    await Future.wait([
      _saveNotification(userId: userId, title: title, body: body, type: 'loan_repayment', groupId: groupId),
      _pushToUser(userId: userId, title: title, body: body, type: 'loan_repayment', groupId: groupId, loanId: loanId),
    ]);
  }

  static Future<void> sendPayoutNotification({
    required String userId,
    required String groupName,
    required double amount,
    String? groupId,
  }) async {
    const title = 'Payout Coming! 🎉';
    final body = 'You are next to receive ${formatRWF(amount)} from "$groupName".';
    await Future.wait([
      _saveNotification(userId: userId, title: title, body: body, type: 'payout', groupId: groupId),
      _pushToUser(userId: userId, title: title, body: body, type: 'payout', groupId: groupId),
    ]);
  }

  static Future<void> sendAnnouncementNotification({
    required String userId,
    required String groupName,
    required String message,
    String? groupId,
  }) async {
    final title = 'Announcement from "$groupName" 📢';
    await Future.wait([
      _saveNotification(userId: userId, title: title, body: message, type: 'announcement', groupId: groupId),
      _pushToUser(userId: userId, title: title, body: message, type: 'announcement', groupId: groupId),
    ]);
  }
}

String formatRWF(double v) => 'RWF ${v.round().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';
