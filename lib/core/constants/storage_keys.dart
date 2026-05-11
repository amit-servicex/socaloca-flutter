/// SharedPreferences keys matching the Android legacy app.
/// Source: Socaloca-legacy/.../libs/Params.java
class StorageKeys {
  StorageKeys._();

  /// Current logged-in user JSON (Player/Coach/Referee/etc.)
  static const String currentUser = 'Msai1Q';

  /// Current logged-in club user JSON
  static const String clubUser = 'Msai1Q_club';

  /// Notification count badge
  static const String notificationCount = 'PCaU7Xg';

  /// Auth token
  static const String authToken = 'auth_token';

  /// User type (from Params.java user type constants)
  static const String userType = 'user_type';

  /// Device ID
  static const String deviceId = 'device_id';

  /// Parent PIN set flag
  static const String parentPinSet = 'parent_pin_set';

  /// Onboarding seen
  static const String onboardingComplete = 'onboarding_complete';

  /// Language selection
  static const String languageCode = 'language_code';
  static const String languageName = 'language_name';
  static const String languageSelected = 'language_selected';

  /// App language
  static const String appLanguage = 'app_language';

  /// Deep link pending data
  static const String pendingDeepLink = 'pending_deep_link';
}
