import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class SocaLocaApp extends ConsumerWidget {
  const SocaLocaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'SocaLoca',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light, // match Android — always light
      routerConfig: router,
      // Level 3 — DefaultTextStyle wraps the entire widget tree.
      // Any Text widget that doesn't inherit from a theme slot (e.g. inside
      // custom painters, overlays, or third-party widgets) will still get
      // Poppins as the base font.
      builder: (context, child) {
        return DefaultTextStyle(
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xFF1C1C1C), // socaBlack
          ),
          child: child!,
        );
      },
    );
  }
}
