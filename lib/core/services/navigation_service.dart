import 'package:flutter/material.dart';

/// Global navigator key shared between GoRouter and PushNotificationService.
/// Set on GoRouter so FCM tap handlers can navigate without a BuildContext.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
