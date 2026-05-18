import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_strings.dart';
import '../storage/storage_service.dart';

/// Manages the app locale.
/// Also keeps [AppStrings] in sync so screens can use AppStrings.xxx anywhere.
class LocaleNotifier extends Notifier<Locale?> {
  @override
  Locale? build() {
    final code = StorageService.languageCode;
    if (code != null && code.isNotEmpty) {
      AppStrings.setLanguage(code); // restore on cold start
      return Locale(code);
    }
    return null; // null → system locale
  }

  Future<void> setLocale(String languageCode, String languageName) async {
    AppStrings.setLanguage(languageCode); // update static strings immediately
    await StorageService.setLanguageCode(languageCode);
    await StorageService.setLanguageName(languageName);
    await StorageService.setLanguageSelected();
    state = Locale(languageCode); // triggers MaterialApp rebuild
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale?>(
  LocaleNotifier.new,
);
