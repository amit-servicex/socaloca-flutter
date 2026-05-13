import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/storage/storage_service.dart';
import '../../../shared/providers/auth_provider.dart';

/// Mirrors SplashActivity — full-screen splash image shown for 2.5 s.
/// After the timer the app routes to home (if logged in), onboarding (first time), or role choice.
/// Status bar is forced black to match Android implementation.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Force black status bar — matches Android window.setStatusBarColor(new_black)
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF1C1C1C),
      statusBarIconBrightness: Brightness.light,
    ));
    _timer = Timer(const Duration(milliseconds: 2500), _navigate);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _navigate() {
    if (!mounted) return;

    // Club admin session takes priority over regular auth
    if (StorageService.isClubLogin) {
      context.go(AppRoutes.clubBioAdmin);
      return;
    }

    final isLoggedIn = ref.read(authStateProvider).isAuthenticated;

    if (isLoggedIn) {
      final user = ref.read(authStateProvider).user;
      if (user?.isReferee == true) {
        context.go(AppRoutes.refereeTournament);
      } else {
        context.go(AppRoutes.home);
      }
    } else {
      // User is not logged in, check onboarding status
      final hasSeenOnboarding = StorageService.onboardingComplete;

      if (hasSeenOnboarding) {
        // User has seen onboarding, go to role choice
        context.go(AppRoutes.roleChoice);
      } else {
        // First time user, show onboarding
        context.go(AppRoutes.onboarding);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Image.asset(
          'assets/images/splash.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
