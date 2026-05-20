import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../models/match_management_models.dart';

final matchManagementRepositoryProvider =
    Provider<MatchManagementRepository>((ref) {
  return const MatchManagementRepository();
});

class MatchManagementRepository {
  const MatchManagementRepository();

  /// Send match score
  /// Matches Android sendMatchScore API
  Future<bool> sendMatchScore({
    required String userId,
    required String matchId,
    required String tournamentId,
    required int homeScore,
    required int awayScore,
    int? homeExtraTimeScore,
    int? awayExtraTimeScore,
    int? homePenaltyScore,
    int? awayPenaltyScore,
    String? winnerId,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'matchId': matchId,
        'tournamentId': tournamentId,
        'homeScore': homeScore,
        'awayScore': awayScore,
      };

      if (homeExtraTimeScore != null) {
        body['homeExtraTimeScore'] = homeExtraTimeScore;
      }
      if (awayExtraTimeScore != null) {
        body['awayExtraTimeScore'] = awayExtraTimeScore;
      }
      if (homePenaltyScore != null) body['homePenaltyScore'] = homePenaltyScore;
      if (awayPenaltyScore != null) body['awayPenaltyScore'] = awayPenaltyScore;
      if (winnerId != null) body['winnerId'] = winnerId;

      final data = await ApiClient.instance.post(
        ApiConstants.sendMatchScore,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return false;

      final status = (response['status'] as num?)?.toInt() ?? 0;
      final success = response['success'] as bool? ?? false;

      return status == 1 && success;
    } on ApiException catch (e) {
      log('Error sending match score: ${e.message}');
      return false;
    } catch (e) {
      log('Error sending match score: $e');
      return false;
    }
  }

  /// Accept match score
  /// Matches Android acceptMatchScore API
  Future<bool> acceptMatchScore({
    required String userId,
    required String matchId,
    required String tournamentId,
    required bool accept,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'matchId': matchId,
        'tournamentId': tournamentId,
        'accept': accept,
      };

      final data = await ApiClient.instance.post(
        ApiConstants.acceptMatchScore,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return false;

      final status = (response['status'] as num?)?.toInt() ?? 0;
      final success = response['success'] as bool? ?? false;

      return status == 1 && success;
    } on ApiException catch (e) {
      log('Error accepting match score: ${e.message}');
      return false;
    } catch (e) {
      log('Error accepting match score: $e');
      return false;
    }
  }

  /// Save match goal details
  /// Matches Android saveMatchGoalDetails API
  Future<bool> saveMatchGoalDetails({
    required String userId,
    required String matchId,
    required String tournamentId,
    required List<MatchGoalModel> goals,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'matchId': matchId,
        'tournamentId': tournamentId,
        'goals': goals
            .map((goal) => {
                  'playerId': goal.playerId,
                  'playerName': goal.playerName,
                  'playerImage': goal.playerImage,
                  'teamId': goal.teamId,
                  'teamName': goal.teamName,
                  'minute': goal.minute,
                  'isOwnGoal': goal.isOwnGoal,
                  'isPenalty': goal.isPenalty,
                  'assistPlayerId': goal.assistPlayerId,
                  'assistPlayerName': goal.assistPlayerName,
                })
            .toList(),
      };

      final data = await ApiClient.instance.post(
        ApiConstants.saveMatchGoalDetails,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return false;

      final status = (response['status'] as num?)?.toInt() ?? 0;
      final success = response['success'] as bool? ?? false;

      return status == 1 && success;
    } on ApiException catch (e) {
      log('Error saving match goal details: ${e.message}');
      return false;
    } catch (e) {
      log('Error saving match goal details: $e');
      return false;
    }
  }

  /// Save match card details
  /// Matches Android saveMatchCardDetails API
  Future<bool> saveMatchCardDetails({
    required String userId,
    required String matchId,
    required String tournamentId,
    required List<MatchCardModel> cards,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'matchId': matchId,
        'tournamentId': tournamentId,
        'cards': cards
            .map((card) => {
                  'playerId': card.playerId,
                  'playerName': card.playerName,
                  'playerImage': card.playerImage,
                  'teamId': card.teamId,
                  'teamName': card.teamName,
                  'cardType': card.cardType,
                  'minute': card.minute,
                  'reason': card.reason,
                })
            .toList(),
      };

      final data = await ApiClient.instance.post(
        ApiConstants.saveMatchCardDetails,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return false;

      final status = (response['status'] as num?)?.toInt() ?? 0;
      final success = response['success'] as bool? ?? false;

      return status == 1 && success;
    } on ApiException catch (e) {
      log('Error saving match card details: ${e.message}');
      return false;
    } catch (e) {
      log('Error saving match card details: $e');
      return false;
    }
  }

  /// Save match MVP
  /// Matches Android saveMatchMvp API
  Future<bool> saveMatchMvp({
    required String userId,
    required String matchId,
    required String tournamentId,
    required String playerId,
    required String playerName,
    String? playerImage,
    required String teamId,
    required String teamName,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'matchId': matchId,
        'tournamentId': tournamentId,
        'playerId': playerId,
        'playerName': playerName,
        'teamId': teamId,
        'teamName': teamName,
      };

      if (playerImage != null) body['playerImage'] = playerImage;

      final data = await ApiClient.instance.post(
        ApiConstants.saveMatchMvp,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return false;

      final status = (response['status'] as num?)?.toInt() ?? 0;
      final success = response['success'] as bool? ?? false;

      return status == 1 && success;
    } on ApiException catch (e) {
      log('Error saving match MVP: ${e.message}');
      return false;
    } catch (e) {
      log('Error saving match MVP: $e');
      return false;
    }
  }

  /// Update match players (squad management)
  /// Matches Android updateMatchPlayers API
  Future<bool> updateMatchPlayers({
    required String userId,
    required String matchId,
    required String tournamentId,
    required String teamId,
    required List<MatchPlayerModel> players,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'matchId': matchId,
        'tournamentId': tournamentId,
        'teamId': teamId,
        'players': players
            .map((player) => {
                  'playerId': player.playerId,
                  'playerName': player.playerName,
                  'playerImage': player.playerImage,
                  'position': player.position,
                  'jerseyNumber': player.jerseyNumber,
                  'isStarting': player.isStarting,
                  'isPlaying': player.isPlaying,
                  'minuteIn': player.minuteIn,
                  'minuteOut': player.minuteOut,
                  'replacedPlayerId': player.replacedPlayerId,
                })
            .toList(),
      };

      final data = await ApiClient.instance.post(
        ApiConstants.updateMatchPlayers,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return false;

      final status = (response['status'] as num?)?.toInt() ?? 0;
      final success = response['success'] as bool? ?? false;

      return status == 1 && success;
    } on ApiException catch (e) {
      log('Error updating match players: ${e.message}');
      return false;
    } catch (e) {
      log('Error updating match players: $e');
      return false;
    }
  }

  /// Save match photos
  /// Matches Android saveMatchPhotos API
  Future<bool> saveMatchPhotos({
    required String userId,
    required String matchId,
    required String tournamentId,
    required List<String> imageUrls,
    List<String>? captions,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'matchId': matchId,
        'tournamentId': tournamentId,
        'imageUrls': imageUrls,
      };

      if (captions != null) body['captions'] = captions;

      final data = await ApiClient.instance.post(
        ApiConstants.saveMatchPhotos,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return false;

      final status = (response['status'] as num?)?.toInt() ?? 0;
      final success = response['success'] as bool? ?? false;

      return status == 1 && success;
    } on ApiException catch (e) {
      log('Error saving match photos: ${e.message}');
      return false;
    } catch (e) {
      log('Error saving match photos: $e');
      return false;
    }
  }

  /// Save match videos
  /// Matches Android saveMatchVideos API
  Future<bool> saveMatchVideos({
    required String userId,
    required String matchId,
    required String tournamentId,
    required List<String> videoUrls,
    List<String>? thumbnailUrls,
    List<String>? titles,
    List<String>? descriptions,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'matchId': matchId,
        'tournamentId': tournamentId,
        'videoUrls': videoUrls,
      };

      if (thumbnailUrls != null) body['thumbnailUrls'] = thumbnailUrls;
      if (titles != null) body['titles'] = titles;
      if (descriptions != null) body['descriptions'] = descriptions;

      final data = await ApiClient.instance.post(
        ApiConstants.saveMatchVideos,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return false;

      final status = (response['status'] as num?)?.toInt() ?? 0;
      final success = response['success'] as bool? ?? false;

      return status == 1 && success;
    } on ApiException catch (e) {
      log('Error saving match videos: ${e.message}');
      return false;
    } catch (e) {
      log('Error saving match videos: $e');
      return false;
    }
  }

  /// Save match rating
  /// Matches Android saveMatchRating API
  Future<bool> saveMatchRating({
    required String userId,
    required String matchId,
    required String tournamentId,
    required List<MatchRatingModel> ratings,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'matchId': matchId,
        'tournamentId': tournamentId,
        'ratings': ratings
            .map((rating) => {
                  'playerId': rating.playerId,
                  'playerName': rating.playerName,
                  'playerImage': rating.playerImage,
                  'teamId': rating.teamId,
                  'rating': rating.rating,
                  'comment': rating.comment,
                })
            .toList(),
      };

      final data = await ApiClient.instance.post(
        ApiConstants.saveMatchRating,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return false;

      final status = (response['status'] as num?)?.toInt() ?? 0;
      final success = response['success'] as bool? ?? false;

      return status == 1 && success;
    } on ApiException catch (e) {
      log('Error saving match rating: ${e.message}');
      return false;
    } catch (e) {
      log('Error saving match rating: $e');
      return false;
    }
  }

  /// Get match details for management
  /// Custom method to fetch comprehensive match data
  Future<MatchDetailsModel?> getMatchDetails({
    required String userId,
    required String matchId,
    required String tournamentId,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'matchId': matchId,
        'tournamentId': tournamentId,
      };

      final data = await ApiClient.instance.post(
        ApiConstants.getMatchData,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return null;

      final status = (response['status'] as num?)?.toInt() ?? 0;
      if (status != 1) return null;

      final matchData = (response['matchDetails'] as Map<String, dynamic>?) ??
          (response['match'] as Map<String, dynamic>?);
      if (matchData == null) return null;

      return MatchDetailsModel.fromJson(matchData);
    } on ApiException catch (e) {
      log('Error getting match details: ${e.message}');
      return null;
    } catch (e) {
      log('Error getting match details: $e');
      return null;
    }
  }

  /// Get match photos
  Future<List<MatchPhotoModel>> getMatchPhotos({
    required String matchId,
  }) async {
    try {
      final body = <String, dynamic>{
        'matchId': matchId,
      };

      final data = await ApiClient.instance.post(
        ApiConstants.getMatchPhotos,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return [];

      final status = (response['status'] as num?)?.toInt() ?? 0;
      if (status != 1) return [];

      final photosData = response['photos'] as List?;
      if (photosData == null) return [];

      return photosData
          .map((json) => MatchPhotoModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ApiException catch (e) {
      log('Error getting match photos: ${e.message}');
      return [];
    } catch (e) {
      log('Error getting match photos: $e');
      return [];
    }
  }

  /// Get match videos
  Future<List<MatchVideoModel>> getMatchVideos({
    required String matchId,
  }) async {
    try {
      final body = <String, dynamic>{
        'matchId': matchId,
      };

      final data = await ApiClient.instance.post(
        ApiConstants.getMatchVideos,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return [];

      final status = (response['status'] as num?)?.toInt() ?? 0;
      if (status != 1) return [];

      final videosData = response['videos'] as List?;
      if (videosData == null) return [];

      return videosData
          .map((json) => MatchVideoModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ApiException catch (e) {
      log('Error getting match videos: ${e.message}');
      return [];
    } catch (e) {
      log('Error getting match videos: $e');
      return [];
    }
  }
}
