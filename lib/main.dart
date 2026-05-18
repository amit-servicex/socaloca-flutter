import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'core/services/push_notification_service.dart';
import 'core/storage/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Register background handler BEFORE Firebase.initializeApp()
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Lock to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Firebase
  await Firebase.initializeApp();

  // Pre-load shared preferences
  await StorageService.init();

  // Initialise FCM (request permission, register token, set up handlers)
  await PushNotificationService.init();

  runApp(
    const ProviderScope(
      child: SocaLocaApp(),
    ),
  );
}
