import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

import '../constants/api_constants.dart';
import '../network/api_client.dart';
import '../router/app_routes.dart';
import '../storage/storage_service.dart';
import 'navigation_service.dart';

// ─── Background handler (must be top-level) ───────────────────────────────────
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Firebase is already initialised by the time this runs.
  // Data-only messages are silently received; no UI update needed here.
  debugPrint('[FCM] Background message: ${message.messageId}');
}

// ─── Notification channel ─────────────────────────────────────────────────────
const _channelId = 'socaloca_default';
const _channelName = 'SocaLoca Notifications';
const _channelDesc = 'SocaLoca push notifications';

final _localNotifications = FlutterLocalNotificationsPlugin();

// ─── Service ─────────────────────────────────────────────────────────────────
class PushNotificationService {
  PushNotificationService._();

  static Future<void> init() async {
    await _initLocalNotifications();
    await _requestPermission();
    await _registerToken();
    _listenForeground();
    _listenTaps();
    await _handleTerminatedTap();
  }

  // ── Local notifications setup ───────────────────────────────────────────────
  static Future<void> _initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await _localNotifications.initialize(
      const InitializationSettings(android: android, iOS: ios),
      onDidReceiveNotificationResponse: _onLocalNotificationTap,
    );

    // Create the Android notification channel
    const channel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDesc,
      importance: Importance.high,
    );
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // ── Permission ──────────────────────────────────────────────────────────────
  static Future<void> _requestPermission() async {
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    debugPrint('[FCM] Permission: ${settings.authorizationStatus}');

    // On Android 13+ we also need the system POST_NOTIFICATIONS runtime grant
    if (Platform.isAndroid) {
      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }
  }

  // ── Token registration ──────────────────────────────────────────────────────
  static Future<void> _registerToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await _sendTokenToServer(token);
      }
      // Refresh token when it rotates
      FirebaseMessaging.instance.onTokenRefresh.listen(_sendTokenToServer);
    } catch (e) {
      debugPrint('[FCM] Token error: $e');
    }
  }

  static Future<void> _sendTokenToServer(String token) async {
    final userId = StorageService.currentUser?['userId'] as String?;
    if (userId == null || userId.isEmpty) return;
    try {
      await ApiClient.instance.post(ApiConstants.updateFcm, body: {
        'userId': userId,
        'fcmToken': token,
        'deviceType': Platform.isIOS ? 'ios' : 'android',
      });
      debugPrint('[FCM] Token registered');
    } catch (e) {
      debugPrint('[FCM] Token registration failed: $e');
    }
  }

  // ── Foreground messages ─────────────────────────────────────────────────────
  static void _listenForeground() {
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint('[FCM] Foreground: ${message.messageId}');
      _showLocalNotification(message);
      _refreshNotificationCount();
    });
  }

  static void _showLocalNotification(RemoteMessage message) {
    final notification = message.notification;
    final title =
        notification?.title ?? message.data['title'] as String? ?? 'SocaLoca';
    final body = notification?.body ?? message.data['body'] as String? ?? '';

    _localNotifications.show(
      message.hashCode,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: jsonEncode(message.data),
    );
  }

  // ── Tap from local notification (foreground) ────────────────────────────────
  static void _onLocalNotificationTap(NotificationResponse response) {
    if (response.payload == null) return;
    try {
      final data = jsonDecode(response.payload!) as Map<String, dynamic>;
      _navigate(data);
    } catch (_) {
      _navigateToNotifications();
    }
  }

  // ── Tap while app is in background ─────────────────────────────────────────
  static void _listenTaps() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint('[FCM] Opened from background: ${message.messageId}');
      _navigate(message.data);
      _refreshNotificationCount();
    });
  }

  // ── Tap from terminated state ───────────────────────────────────────────────
  static Future<void> _handleTerminatedTap() async {
    final message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      debugPrint('[FCM] Launched from terminated: ${message.messageId}');
      // Delay to let the router finish initialising before we push
      await Future.delayed(const Duration(milliseconds: 500));
      _navigate(message.data);
      _refreshNotificationCount();
    }
  }

  // ── Navigation ──────────────────────────────────────────────────────────────
  static void _navigate(Map<String, dynamic> data) {
    final type = data['notificationType'] as String? ?? '';
    final context = navigatorKey.currentContext;
    if (context == null) {
      debugPrint('[FCM] No context for navigation');
      return;
    }

    try {
      final route = _routeForType(type, data);
      if (route != null) {
        context.push(route);
      } else {
        _navigateToNotifications();
      }
    } catch (e) {
      debugPrint('[FCM] Navigation error: $e');
      _navigateToNotifications();
    }
  }

  static String? _routeForType(String type, Map<String, dynamic> data) {
    final userId =
        data['senderUserId'] as String? ?? data['userId'] as String? ?? '';
    final teamId = data['teamId'] as String? ?? '';
    final matchId = data['matchId'] as String? ?? '';
    final tournamentId = data['tournamentId'] as String? ?? '';
    final clubId = data['clubId'] as String? ?? '';
    final academyId = data['academyId'] as String? ?? '';

    switch (type) {
      // ── Social ────────────────────────────────────────────────────────────
      case 'likeUser':
      case 'followUser':
      case 'newUserJoin':
      case 'likePost':
      case 'newUserPost':
      case 'userSkillPost':
      case 'userTagPost':
      case 'feedComment':
      case 'feedCommentLike':
      case 'endorsePlayer':
      case 'newEndorse':
        return userId.isNotEmpty
            ? AppRoutes.playerBio.replaceFirst(':userId', userId)
            : null;

      // ── Team ──────────────────────────────────────────────────────────────
      case 'requestTeamJoin':
      case 'respondTeamJoinRequest':
      case 'inviteTeamUser':
      case 'editTeam':
      case 'newTeamAlert':
        return teamId.isNotEmpty
            ? AppRoutes.teamBio.replaceFirst(':teamId', teamId)
            : null;

      // ── Pick-up matches ───────────────────────────────────────────────────
      case 'pickUpRequest':
      case 'acceptPickUpRequest':
      case 'nearPickUp':
        return matchId.isNotEmpty
            ? AppRoutes.pickupMatchDetail.replaceFirst(':matchId', matchId)
            : AppRoutes.pickupMatches;

      // ── Live match ────────────────────────────────────────────────────────
      case 'liveMatchUpdate':
        return matchId.isNotEmpty
            ? AppRoutes.liveMatchDetails.replaceFirst(':matchId', matchId)
            : AppRoutes.playerLiveMatches;

      // ── Tournament ────────────────────────────────────────────────────────
      case 'tournamentInvite':
      case 'tournamentAccept':
      case 'tournamentConfirm':
      case 'leagueNotice':
      case 'teamTournament':
      case 'newTmntAlert':
      case 'fixtureChange':
        return tournamentId.isNotEmpty
            ? AppRoutes.tournamentDetail.replaceFirst(':tmntId', tournamentId)
            : AppRoutes.tournaments;

      // ── Cup ───────────────────────────────────────────────────────────────
      case 'cupInvite':
      case 'cupConfirm':
      case 'cupAccept':
      case 'cupNotice':
        return tournamentId.isNotEmpty
            ? AppRoutes.cupDetail.replaceFirst(':cupId', tournamentId)
            : AppRoutes.tournaments;

      // ── Club ──────────────────────────────────────────────────────────────
      case 'fromClub':
        return clubId.isNotEmpty
            ? AppRoutes.clubBio.replaceFirst(':clubId', clubId)
            : null;

      // ── Academy ───────────────────────────────────────────────────────────
      case 'fromAcademy':
      case 'acceptAcademy':
        return academyId.isNotEmpty
            ? AppRoutes.academyBio.replaceFirst(':academyId', academyId)
            : AppRoutes.academies;

      // ── Referee ───────────────────────────────────────────────────────────
      case 'assignReferee':
        return AppRoutes.refereeMatches;

      // ── FA / Confed / Sponsor / Charity → notifications fallback ─────────
      case 'fromFA':
        return AppRoutes.notifications;
      case 'fromConfed':
        return AppRoutes.notifications;
      case 'fromSpon':
        return AppRoutes.notifications;
      case 'fromCharity':
        return AppRoutes.notifications;

      default:
        return null;
    }
  }

  static void _navigateToNotifications() {
    navigatorKey.currentContext?.push(AppRoutes.notifications);
  }

  // ── Notification count refresh ──────────────────────────────────────────────
  static void _refreshNotificationCount() {
    final userId = StorageService.currentUser?['userId'] as String?;
    if (userId == null || userId.isEmpty) return;
    ApiClient.instance
        .post(ApiConstants.getNotificationCount, body: {'userId': userId})
        .then((_) {})
        .catchError((_) {});
  }
}
