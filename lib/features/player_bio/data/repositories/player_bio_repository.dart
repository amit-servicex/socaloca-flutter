import 'dart:developer';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/player_bio_model.dart';
import '../models/game_stats_model.dart';
import '../models/match_training_status_model.dart';
import '../models/player_team_model.dart';
import '../models/player_skill_model.dart';
import '../models/player_post_model.dart';
import '../models/endorsement_model.dart';
import '../models/academy_model.dart';
import '../models/tournament_model.dart';
import '../models/tagged_video_model.dart';

/// Repository for player bio related API calls
class PlayerBioRepository {
  /// Get player bio details
  Future<PlayerBioModel?> getPlayerBio({
    required String userId,
    required String playerId,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getPlayerBio,
        body: {
          'userId': userId,
          'playerId': playerId,
        },
      );

      if (response['response']['status'] == 1 &&
          response['response']['playerDetails'] != null) {
        return PlayerBioModel.fromJson(
          response['response']['playerDetails'] as Map<String, dynamic>,
        );
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  /// Follow/unfollow user
  Future<Map<String, dynamic>> followUser({
    required String userId,
    required String toUserId,
    required String myName,
    required String myImageUrl,
    required bool isPlayer,
    required bool isCoach,
    required bool isAdmin,
    required bool isFan,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.followUser,
        body: {
          'userId': userId,
          'toUserId': toUserId,
          'myName': myName,
          'myImageUrl': myImageUrl,
          'isPlayer': isPlayer,
          'isCoach': isCoach,
          'isAdmin': isAdmin,
          'isFan': isFan,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Like/unlike user
  Future<Map<String, dynamic>> likeUser({
    required String userId,
    required String toUserId,
    required String myName,
    required String myImageUrl,
    required bool isPlayer,
    required bool isCoach,
    required bool isAdmin,
    required bool isFan,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.likeUser,
        body: {
          'userId': userId,
          'toUserId': toUserId,
          'myName': myName,
          'myImageUrl': myImageUrl,
          'isPlayer': isPlayer,
          'isCoach': isCoach,
          'isAdmin': isAdmin,
          'isFan': isFan,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get player stats (Football & Futsal)
  Future<Map<String, GameStatsModel?>> getPlayerStats({
    required String playerId,
    required int year,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getPlayerStats,
        body: {
          'playerId': playerId,
          'year': year,
        },
      );

      if (response['response']['result'] == 1) {
        GameStatsModel? football;
        GameStatsModel? futsal;

        if (response['response']['stats'] != null) {
          football = GameStatsModel.fromJson(
            response['response']['stats'] as Map<String, dynamic>,
          );
        }

        if (response['response']['statsFutsal'] != null) {
          futsal = GameStatsModel.fromJson(
            response['response']['statsFutsal'] as Map<String, dynamic>,
          );
        }

        return {
          'football': football,
          'futsal': futsal,
        };
      }
      return {
        'football': null,
        'futsal': null,
      };
    } catch (e) {
      rethrow;
    }
  }

  /// Get mini activity (matches & training stats)
  Future<Map<String, dynamic>> getMiniActivity({
    required String playerId,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getMiniActivity,
        body: {
          'playerId': playerId,
        },
      );

      if (response['response']['status'] == 1) {
        MatchTrainingStatusModel? football;
        MatchTrainingStatusModel? futsal;
        MatchTrainingStatusModel? trainCurrMonth;
        MatchTrainingStatusModel? trainPrevMonth;
        String? lastYear;

        if (response['response']['football'] != null) {
          football = MatchTrainingStatusModel.fromJson(
            response['response']['football'] as Map<String, dynamic>,
          );
        }

        if (response['response']['futsal'] != null) {
          futsal = MatchTrainingStatusModel.fromJson(
            response['response']['futsal'] as Map<String, dynamic>,
          );
        }

        if (response['response']['trainCurrMonth'] != null) {
          trainCurrMonth = MatchTrainingStatusModel.fromJson(
            response['response']['trainCurrMonth'] as Map<String, dynamic>,
          );
        }

        if (response['response']['trainPrevMonth'] != null) {
          trainPrevMonth = MatchTrainingStatusModel.fromJson(
            response['response']['trainPrevMonth'] as Map<String, dynamic>,
          );
        }

        if (response['response']['lastYear'] != null) {
          lastYear = response['response']['lastYear'].toString();
        }

        return {
          'football': football,
          'futsal': futsal,
          'trainCurrMonth': trainCurrMonth,
          'trainPrevMonth': trainPrevMonth,
          'lastYear': lastYear,
        };
      }
      return {};
    } catch (e) {
      rethrow;
    }
  }

  /// Get player teams
  Future<List<PlayerTeamModel>> getPlayerTeams({
    required String playerId,
    int start = 0,
    int limit = 20,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getPlayerTeams,
        body: {
          'playerId': playerId,
          'start': start,
          'limit': limit,
        },
      );

      if (response['response']['status'] == 1 &&
          response['response']['teams'] != null) {
        final teams = response['response']['teams'] as List;
        return teams
            .map((team) =>
                PlayerTeamModel.fromJson(team as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  /// Get player skills/ratings
  Future<Map<String, dynamic>> getPlayerSkills({
    required String userId,
    required String playerId,
    int start = 0,
    int limit = 5,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getPlayerSkills,
        body: {
          'userId': userId,
          'playerId': playerId,
          'start': start,
          'limit': limit,
        },
      );

      if (response['response']['status'] == 1) {
        List<PlayerSkillModel> skills = [];
        double? overall;

        if (response['response']['skills'] != null) {
          final skillsList = response['response']['skills'] as List;
          skills = skillsList
              .map((skill) =>
                  PlayerSkillModel.fromJson(skill as Map<String, dynamic>))
              .toList();
          log("successfully parse the data of the rating and skill of the player ${skillsList.first}");
        }

        if (response['response']['overall'] != null) {
          overall = (response['response']['overall'] as num).toDouble();
        }

        return {
          'skills': skills,
          'overall': overall,
        };
      }
      return {
        'skills': <PlayerSkillModel>[],
        'overall': null,
      };
    } catch (e) {
      rethrow;
    }
  }

  /// Get user posts
  Future<List<PlayerPostModel>> getUserPosts({
    required String userId,
    required String myId,
    int start = 0,
    int limit = 5,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getUserPosts,
        body: {
          'userId': userId,
          'myId': myId,
          'start': start,
          'limit': limit,
        },
      );

      if (response['response']['status'] == 1 &&
          response['response']['posts'] != null) {
        final posts = response['response']['posts'] as List;
        return posts
            .map((post) =>
                PlayerPostModel.fromJson(post as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  /// Get endorsements
  Future<List<EndorsementModel>> getEndorses({
    required String userId,
    String endType = 'accept',
    int start = 0,
    int limit = 1,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getEndorses,
        body: {
          'userId': userId,
          'endType': endType,
          'start': start,
          'limit': limit,
        },
      );

      if (response['response']['status'] == 1 &&
          response['response']['ends'] != null) {
        final ends = response['response']['ends'] as List;
        return ends
            .map(
                (end) => EndorsementModel.fromJson(end as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  /// Get user academies
  Future<List<AcademyModel>> getUserAcademy({
    required String userId,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getUserAcademy,
        body: {
          'userId': userId,
        },
      );

      if (response['response']['status'] == 1 &&
          response['response']['academys'] != null) {
        final academys = response['response']['academys'] as List;
        return academys
            .map((academy) =>
                AcademyModel.fromJson(academy as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  /// Get player tournaments
  Future<List<TournamentModel>> getPlayerTmnts({
    required String playerId,
    int start = 0,
    int limit = 20,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getPlayerTmnts,
        body: {
          'playerId': playerId,
          'start': start,
          'limit': limit,
        },
      );

      if (response['response']['status'] == 1 &&
          response['response']['tmnts'] != null) {
        final tmnts = response['response']['tmnts'] as List;
        return tmnts
            .map((tmnt) =>
                TournamentModel.fromJson(tmnt as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  /// Add a match activity entry (Football or Futsal)
  Future<bool> addMatchActivity({
    required String userId,
    required String gameType,
    required String matchDate,
    required int matchMonth,
    required int matchYear,
    required String matchMonthStr,
    required int goals,
    required int goalSaved,
    required int assists,
    required String playPosition,
    required String playPositionType,
    required int minutes,
    required String myTeamName,
    required String opponentTeamName,
    required int rating,
    required String notes,
    List<Map<String, dynamic>> tagged = const [],
    required bool isPlayer,
    required bool isCoach,
    required bool isAdmin,
    required bool isFan,
    required String firstName,
    required String lastName,
    required String myImageUrl,
  }) async {
    try {
      final formattedDate = _formatDateForApi(matchDate);
      final response = await ApiClient.instance.post(
        ApiConstants.addMatchActivity,
        body: {
          'userId': userId,
          'gameType': gameType,
          'matchDate': formattedDate,
          'matchDateGmt': DateTime.now().millisecondsSinceEpoch,
          'matchMonth': matchMonth,
          'matchYear': matchYear,
          'matchMonthStr': matchMonthStr,
          'goals': goals,
          'goalSaved': goalSaved,
          'assists': assists,
          'playPosition': playPosition,
          'playPositionType': playPositionType,
          'minutes': minutes,
          'myTeamName': myTeamName,
          'opponentTeamName': opponentTeamName,
          'rating': rating,
          'notes': notes,
          'tagged': tagged,
          'isAdmin': isAdmin,
          'isPlayer': isPlayer,
          'isCoach': isCoach,
          'isFan': isFan,
          'firstName': firstName,
          'lastName': lastName,
          'myImageUrl': myImageUrl,
        },
      );
      return response['response']?['status'] == 1 &&
          response['response']?['success'] == true;
    } catch (e) {
      rethrow;
    }
  }

  /// Add a training session activity
  Future<bool> addTrainingActivity({
    required String userId,
    required String trainType,
    required String trainDate,
    required int trainMonth,
    required int trainYear,
    required String trainMonthStr,
    required int minutes,
    required String notes,
    List<Map<String, dynamic>> tagged = const [],
    required bool isPlayer,
    required bool isCoach,
    required bool isAdmin,
    required bool isFan,
    required String firstName,
    required String lastName,
    required String myImageUrl,
  }) async {
    try {
      final formattedDate = _formatDateForApi(trainDate);
      final response = await ApiClient.instance.post(
        ApiConstants.addTrainingActivity,
        body: {
          'userId': userId,
          'trainType': trainType.toLowerCase(),
          'trainDate': formattedDate,
          'trainDateGmt': DateTime.now().millisecondsSinceEpoch,
          'trainMonth': trainMonth,
          'trainYear': trainYear,
          'trainMonthStr': trainMonthStr,
          'minutes': minutes,
          'notes': notes,
          'tagged': tagged,
          'isAdmin': isAdmin,
          'isPlayer': isPlayer,
          'isCoach': isCoach,
          'isFan': isFan,
          'firstName': firstName,
          'lastName': lastName,
          'myImageUrl': myImageUrl,
        },
      );
      return response['response']?['status'] == 1 &&
          response['response']?['success'] == true;
    } catch (e) {
      rethrow;
    }
  }

  /// Convert a DateTime to yyyy-MM-dd format expected by the API
  String _formatDateForApi(String ddMMYyyy) {
    try {
      final parts = ddMMYyyy.split('-');
      if (parts.length == 3) return '${parts[2]}-${parts[1]}-${parts[0]}';
    } catch (_) {}
    return ddMMYyyy;
  }

  /// Get player academy videos (tagged videos)
  Future<List<TaggedVideoModel>> getPlayerAcaVdos({
    required String userId,
    required String playerId,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getPlayerAcaVdos,
        body: {
          'userId': userId,
          'playerId': playerId,
        },
      );

      if (response['response']['status'] == 1 &&
          response['response']['vdos'] != null) {
        final vdos = response['response']['vdos'] as List;
        return vdos
            .map(
                (vdo) => TaggedVideoModel.fromJson(vdo as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
