import 'dart:math';

import '../constants/storage_keys.dart';
import '../storage/storage_service.dart';

/// Generates and persists a unique device ID for this installation.
/// Used in every auth API call (modSignIn, modSignUp, socialLogin, clubLogin).
class DeviceInfo {
  DeviceInfo._();

  static String get deviceId {
    var id = StorageService.getString(StorageKeys.deviceId);
    if (id == null || id.isEmpty) {
      id = _generate();
      StorageService.setString(StorageKeys.deviceId, id);
    }
    return id;
  }

  static String _generate() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final rng = Random.secure();
    return List.generate(32, (_) => chars[rng.nextInt(chars.length)]).join();
  }
}
