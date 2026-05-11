import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';
import 'models/match_update_model.dart';

/// Repository for home screen API calls
class HomeRepository {
  const HomeRepository();

  // ─── Get Blocked Users ────────────────────────────────────────────────────

  Future<List<String>> getBlockedUsers(String userId) async {
    try {
      final data = await ApiClient.instance.post(
        ApiConstants.getUserBlocked,
        body: {'userId': userId},
      );

      if (data['status'] == 1 && data['success'] == true) {
        final blockList = data['blockList'] as List<dynamic>?;
        if (blockList != null) {
          return blockList.map((e) => e.toString()).toList();
        }
      }
      return [];
    } on ApiException catch (e) {
      print('Error getting blocked users: ${e.message}');
      return [];
    }
  }

  // ─── Get Notification Count ───────────────────────────────────────────────

  Future<int> getNotificationCount(String userId) async {
    try {
      final data = await ApiClient.instance.post(
        ApiConstants.getNotificationCount,
        body: {'userId': userId},
      );

      if (data['status'] == 1) {
        return (data['count'] as num?)?.toInt() ?? 0;
      }
      return 0;
    } on ApiException catch (e) {
      print('Error getting notification count: ${e.message}');
      return 0;
    }
  }

  // ─── Check App Update ─────────────────────────────────────────────────────

  Future<Map<String, dynamic>?> checkAppUpdate() async {
    try {
      final data = await ApiClient.instance.post(
        ApiConstants.checkAppUpdate,
        body: {},
      );

      if (data['status'] == 1) {
        return data;
      }
      return null;
    } on ApiException catch (e) {
      print('Error checking app update: ${e.message}');
      return null;
    }
  }

  // ─── Get Match Updates ────────────────────────────────────────────────────
  /// Fetches match updates for Player/Coach/Manager/Admin roles
  /// Matches Android UPDATEMATCH API
  Future<List<MatchUpdateModel>> getMatchUpdates(String userId) async {
    try {
      final data = await ApiClient.instance.post(
        ApiConstants.matchUpdates,
        body: {'userId': userId},
      );

      if (data['response'] != null &&
          data['response']['status'] == 1 &&
          data['response']['matches'] != null) {
        final matches = data['response']['matches'] as List<dynamic>;
        return matches
            .whereType<Map<String, dynamic>>()
            .map(MatchUpdateModel.fromJson)
            .toList();
      }
      return [];
    } on ApiException catch (e) {
      print('Error getting match updates: ${e.message}');
      return [];
    }
  }

  // ─── Get User Profile ─────────────────────────────────────────────────────
  /// Fetches complete user profile
  /// Matches Android GET_USER_PROFILE API
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    try {
      final data = await ApiClient.instance.post(
        ApiConstants.getUserProfile,
        body: {'userId': userId},
      );

      if (data['response']['status'] == 1 &&
          data['response']['userDetails'] != null) {
        return data['response']['userDetails'] as Map<String, dynamic>;
      }
      return null;
    } on ApiException catch (e) {
      print('Error getting user profile: ${e.message}');
      return null;
    }
  }
}
