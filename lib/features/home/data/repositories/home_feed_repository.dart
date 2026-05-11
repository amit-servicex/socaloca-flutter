import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/endorsed_player_model.dart';
import '../models/feed_new_team_model.dart';
import '../models/feed_rec_user_model.dart';
import '../models/feed_tournament_model.dart';

/// Repository for home feed APIs
class HomeFeedRepository {
  /// Get live tournaments for feed
  Future<List<FeedTournamentModel>> getFeedLiveTmnts({
    required String userId,
    int start = 0,
    int limit = 10,
  }) async {
    try {
      print('🔵 Calling getFeedLiveTmnts API with userId: $userId');

      final response = await ApiClient.instance.post(
        ApiConstants.getFeedLiveTmnts,
        body: {
          'userId': userId,
          'start': start,
          'limit': limit,
        },
      );

      final data = response['response'] as Map<String, dynamic>?;
      final status = data?['status'];
      print('🔵 getFeedLiveTmnts response: $status');

      if ((status == 1 || status == '1') && data?['tmnts'] != null) {
        final tmnts = data!['tmnts'] as List;
        print('🔵 getFeedLiveTmnts returned ${tmnts.length} tournaments');
        return tmnts.map((t) {
          final tournament = t as Map<String, dynamic>;
          final feedId = tournament['feedId'];
          final feedType = tournament['feedType'];
          final tmntDetails =
              tournament['tmntDetails'] as Map<String, dynamic>?;
          final comments = tournament['comments'] as List?;

          // Merge wrapper fields with tmntDetails for model parsing
          final mergedData = {
            'feedId': feedId,
            'feedType': feedType,
            'comments': comments ?? [],
            ...?tmntDetails, // Spread tmntDetails fields
          };

          return FeedTournamentModel.fromJson(mergedData);
        }).toList();
      }
      print('🔵 getFeedLiveTmnts returned empty list');
      return [];
    } catch (e) {
      print('❌ Error in getFeedLiveTmnts: $e');
      return [];
    }
  }

  /// Get new teams for feed
  Future<List<FeedNewTeamModel>> getFeedNewTeams({
    required String userId,
    int start = 0,
    int limit = 10,
  }) async {
    try {
      print('🔵 Calling getFeedNewTeams API with userId: $userId');

      final response = await ApiClient.instance.post(
        ApiConstants.getFeedNewTeams,
        body: {
          'userId': userId,
          'start': start,
          'limit': limit,
        },
      );

      final data = response['response'] as Map<String, dynamic>?;
      final status = data?['status'];
      print('🔵 getFeedNewTeams response: $status');

      if ((status == 1 || status == '1') && data?['teams'] != null) {
        final teams = data!['teams'] as List;
        print('🔵 getFeedNewTeams returned ${teams.length} teams');
        return teams
            .map((t) => FeedNewTeamModel.fromJson(t as Map<String, dynamic>))
            .toList();
      }
      print('🔵 getFeedNewTeams returned empty list');
      return [];
    } catch (e) {
      print('❌ Error in getFeedNewTeams: $e');
      return [];
    }
  }

  /// Get recommended users for feed
  Future<List<FeedRecUserModel>> getFeedRecUsers({
    required String userId,
    int start = 0,
    int limit = 10,
  }) async {
    try {
      print('🔵 Calling getFeedRecUsers API with userId: $userId');

      final response = await ApiClient.instance.post(
        ApiConstants.getFeedRecUsers,
        body: {
          'userId': userId,
          'start': start,
          'limit': limit,
        },
      );

      final data = response['response'] as Map<String, dynamic>?;
      final status = data?['status'];
      print('🔵 getFeedRecUsers response: $status');

      if ((status == 1 || status == '1') && data?['uList'] != null) {
        final users = data!['uList'] as List;
        print('🔵 getFeedRecUsers returned ${users.length} users');
        return users
            .map((u) => FeedRecUserModel.fromJson(u as Map<String, dynamic>))
            .toList();
      }
      print('🔵 getFeedRecUsers returned empty list');
      return [];
    } catch (e) {
      print('❌ Error in getFeedRecUsers: $e');
      return [];
    }
  }

  /// Get most endorsed players
  Future<List<EndorsedPlayerModel>> getMostEndorsed({
    required String userId,
    int offset = 0,
    int limit = 10,
  }) async {
    try {
      print('🔵 Calling getMostEndorsed API with userId: $userId');

      final response = await ApiClient.instance.post(
        ApiConstants.getMostEndorsed,
        body: {
          'userId': userId,
          'offset': offset,
          'limit': limit,
        },
      );

      final data = response['response'] as Map<String, dynamic>?;
      final status = data?['status'];
      print('🔵 getMostEndorsed response: $status');

      if ((status == 1 || status == '1') && data?['users'] != null) {
        final users = data!['users'] as List;
        print('🔵 getMostEndorsed returned ${users.length} users');
        return users
            .map((u) => EndorsedPlayerModel.fromJson(u as Map<String, dynamic>))
            .toList();
      }
      print('🔵 getMostEndorsed returned empty list');
      return [];
    } catch (e) {
      print('❌ Error in getMostEndorsed: $e');
      return [];
    }
  }

  /// Get user profile
  Future<Map<String, dynamic>?> getUserProfile({
    required String userId,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getUserProfile,
        body: {'userId': userId},
      );

      if (response['status'] == 1 && response['userDetails'] != null) {
        return response['userDetails'] as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      print('❌ Error in getUserProfile: $e');
      return null;
    }
  }

  /// Get feed team list (most followed teams)
  /// Matches Android GET_FEED_TEAM_LIST API
  Future<List<Map<String, dynamic>>> getFeedTeamList({
    required String userId,
    int start = 0,
    int limit = 10,
  }) async {
    try {
      print('🔵 Calling getFeedTeamList API with userId: $userId');

      final response = await ApiClient.instance.post(
        ApiConstants.getFeedTeamList,
        body: {
          'userId': userId,
          'start': start,
          'limit': limit,
        },
      );

      final data = response['response'] as Map<String, dynamic>?;
      final status = data?['status'];
      print('🔵 getFeedTeamList response: $status');

      if ((status == 1 || status == '1') && data?['teams'] != null) {
        final teams = data!['teams'] as List;
        print('🔵 getFeedTeamList returned ${teams.length} teams');
        return teams.map((t) {
          final teamMap = t as Map<String, dynamic>;
          return {
            ...teamMap,
            'id': teamMap['teamId'] ?? teamMap['id'],
            'name': teamMap['teamName'] ?? teamMap['name'],
            'logo': teamMap['imageUrl'] ?? teamMap['logo'],
            'teamLogo': teamMap['imageUrl'] ?? teamMap['logo'],
          };
        }).toList();
      }
      print('🔵 getFeedTeamList returned empty list');
      return [];
    } catch (e) {
      print('❌ Error in getFeedTeamList: $e');
      return [];
    }
  }

  /// Check for app updates
  Future<Map<String, dynamic>?> checkAppUpdate({
    required String userId,
    required String version,
    required String platform,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.chkUpdt,
        body: {
          'userId': userId,
          'version': version,
          'platform': platform,
        },
      );

      return response;
    } catch (e) {
      print('❌ Error in checkAppUpdate: $e');
      return null;
    }
  }
}
