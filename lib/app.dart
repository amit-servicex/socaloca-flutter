import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/providers/locale_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';

class SocaLocaApp extends ConsumerWidget {
  const SocaLocaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'SocaLoca',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light, // match Android — always light
      routerConfig: router,

      // Localization
      locale: locale, // null → system locale
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,

      // Level 3 — DefaultTextStyle wraps the entire widget tree.
      builder: (context, child) {
        return KeyedSubtree(
          key: ValueKey(locale?.languageCode ?? 'system'),
          child: DefaultTextStyle(
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xFF1C1C1C), // socaBlack
            ),
            child: child!,
          ),
        );
      },
    );
  }
}
