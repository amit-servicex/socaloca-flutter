import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../constants/storage_keys.dart';

/// Thin wrapper around SharedPreferences.
/// All keys mirror the Android legacy keys from Params.java.
class StorageService {
  StorageService._();

  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ─── Generic ─────────────────────────────────────────────────────────────
  static String? getString(String key) => _prefs.getString(key);
  static Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  static int? getInt(String key) => _prefs.getInt(key);
  static Future<bool> setInt(String key, int value) =>
      _prefs.setInt(key, value);

  static bool? getBool(String key) => _prefs.getBool(key);
  static Future<bool> setBool(String key, bool value) =>
      _prefs.setBool(key, value);

  static Future<bool> remove(String key) => _prefs.remove(key);

  // ─── Typed helpers ────────────────────────────────────────────────────────

  static Map<String, dynamic>? getJson(String key) {
    final raw = _prefs.getString(key);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  static Future<bool> setJson(String key, Map<String, dynamic> value) =>
      _prefs.setString(key, jsonEncode(value));

  // ─── Auth shortcuts ───────────────────────────────────────────────────────

  static String? get authToken => getString(StorageKeys.authToken);
  static Future<bool> setAuthToken(String token) =>
      setString(StorageKeys.authToken, token);

  static Map<String, dynamic>? get currentUser =>
      getJson(StorageKeys.currentUser);
  static Future<bool> setCurrentUser(Map<String, dynamic> user) =>
      setJson(StorageKeys.currentUser, user);

  static Map<String, dynamic>? get clubUser => getJson(StorageKeys.clubUser);
  static Future<bool> setClubUser(Map<String, dynamic> user) =>
      setJson(StorageKeys.clubUser, user);

  /// True when current session is a club admin login.
  static bool get isClubLogin => getBool(StorageKeys.isClubLogin) ?? false;
  static Future<bool> setClubLogin(bool value) =>
      setBool(StorageKeys.isClubLogin, value);

  /// Shortcut: the club's primary identifier from the stored club user.
  static String? get clubId {
    final user = clubUser;
    return user?['clubId']?.toString();
  }

  /// Get current user ID
  static String? get userId {
    final user = currentUser;
    return user?['userId'] ?? user?['_id'] ?? user?['id'];
  }

  /// Get current user email
  static String? get userEmail {
    final user = currentUser;
    return user?['email'];
  }

  static int get notificationCount =>
      getInt(StorageKeys.notificationCount) ?? 0;
  static Future<bool> setNotificationCount(int count) =>
      setInt(StorageKeys.notificationCount, count);

  static bool get onboardingComplete =>
      getBool(StorageKeys.onboardingComplete) ?? false;
  static Future<bool> setOnboardingComplete() =>
      setBool(StorageKeys.onboardingComplete, true);
  static Future<bool> clearOnboarding() =>
      remove(StorageKeys.onboardingComplete);

  // ─── Language ─────────────────────────────────────────────────────────────
  static String? get languageCode => getString(StorageKeys.languageCode);
  static Future<bool> setLanguageCode(String code) =>
      setString(StorageKeys.languageCode, code);

  static String? get languageName => getString(StorageKeys.languageName);
  static Future<bool> setLanguageName(String name) =>
      setString(StorageKeys.languageName, name);

  static bool get languageSelected =>
      getBool(StorageKeys.languageSelected) ?? false;
  static Future<bool> setLanguageSelected() =>
      setBool(StorageKeys.languageSelected, true);

  // ─── Clear all ────────────────────────────────────────────────────────────
  static Future<bool> clearAll() => _prefs.clear();

  static Future<void> clearUserSession() async {
    await remove(StorageKeys.authToken);
    await remove(StorageKeys.currentUser);
    await remove(StorageKeys.clubUser);
    await remove(StorageKeys.isClubLogin);
    await remove(StorageKeys.userType);
    await remove(StorageKeys.notificationCount);
  }
}
