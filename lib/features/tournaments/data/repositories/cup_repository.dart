import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../models/cup_models.dart';

final cupRepositoryProvider = Provider<CupRepository>((ref) {
  return const CupRepository();
});

class CupRepository {
  const CupRepository();

  /// Get cup tournament details
  /// Matches Android getCupDetails API
  Future<TournamentCupModel?> getCupDetails({
    required String userId,
    required String tournamentId,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'tournamentId': tournamentId,
      };

      final data = await ApiClient.instance.post(
        ApiConstants.getCupDetails,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return null;

      final status = (response['status'] as num?)?.toInt() ?? 0;
      if (status != 1) return null;

      final details = response['details'] as Map<String, dynamic>?;
      if (details == null) return null;

      // Parse banners
      List<CupBannerModel>? banners;
      if (details['banners'] != null && details['banners'] is List) {
        final bannersData = details['banners'] as List;
        banners = bannersData
            .map((json) =>
                CupBannerModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      // Parse teams
      List<CupTeamModel>? teams;
      if (response['teams'] != null && response['teams'] is List) {
        final teamsData = response['teams'] as List;
        teams = teamsData
            .map(
                (json) => CupTeamModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      // Parse sponsors
      List<CupSponsorModel>? sponsors;
      if (response['sponsors'] != null && response['sponsors'] is List) {
        final sponsorsData = response['sponsors'] as List;
        sponsors = sponsorsData
            .map((json) =>
                CupSponsorModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      // Parse rounds
      List<CupRoundModel>? roundsList;
      if (response['rounds'] != null && response['rounds'] is List) {
        final roundsData = response['rounds'] as List;
        roundsList = roundsData
            .map((json) =>
                CupRoundModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      final cup = TournamentCupModel.fromJson(details);
      return cup.copyWith(
        banners: banners,
        teams: teams,
        sponsors: sponsors,
        roundsList: roundsList,
      );
    } on ApiException catch (e) {
      log('Error getting cup details: ${e.message}');
      return null;
    } catch (e) {
      log('Error getting cup details: $e');
      return null;
    }
  }

  /// Get cup ready detail (for active/live cups)
  /// Matches Android getCupReadyDetail API
  Future<TournamentCupModel?> getCupReadyDetail({
    required String userId,
    required String tournamentId,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'tournamentId': tournamentId,
      };

      final data = await ApiClient.instance.post(
        ApiConstants.getCupReadyDetail,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return null;

      final status = (response['status'] as num?)?.toInt() ?? 0;
      if (status != 1) return null;

      final details = response['details'] as Map<String, dynamic>?;
      if (details == null) return null;

      // Parse similar to getCupDetails
      List<CupBannerModel>? banners;
      if (details['banners'] != null && details['banners'] is List) {
        final bannersData = details['banners'] as List;
        banners = bannersData
            .map((json) =>
                CupBannerModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      List<CupTeamModel>? teams;
      if (response['teams'] != null && response['teams'] is List) {
        final teamsData = response['teams'] as List;
        teams = teamsData
            .map(
                (json) => CupTeamModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      List<CupSponsorModel>? sponsors;
      if (response['sponsors'] != null && response['sponsors'] is List) {
        final sponsorsData = response['sponsors'] as List;
        sponsors = sponsorsData
            .map((json) =>
                CupSponsorModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      List<CupRoundModel>? roundsList;
      if (response['rounds'] != null && response['rounds'] is List) {
        final roundsData = response['rounds'] as List;
        roundsList = roundsData
            .map((json) =>
                CupRoundModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      final cup = TournamentCupModel.fromJson(details);
      return cup.copyWith(
        banners: banners,
        teams: teams,
        sponsors: sponsors,
        roundsList: roundsList,
      );
    } on ApiException catch (e) {
      log('Error getting cup ready detail: ${e.message}');
      return null;
    } catch (e) {
      log('Error getting cup ready detail: $e');
      return null;
    }
  }

  /// Get cup group matches
  /// Matches Android getCupGroupMatches API
  Future<CupGroupModel?> getCupGroupMatches({
    required String userId,
    required String tournamentId,
    required String roundId,
    required String groupId,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'tournamentId': tournamentId,
        'roundId': roundId,
        'groupId': groupId,
      };

      final data = await ApiClient.instance.post(
        ApiConstants.getCupGroupMatches,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return null;

      final status = (response['status'] as num?)?.toInt() ?? 0;
      if (status != 1) return null;

      final groupData = response['group'] as Map<String, dynamic>?;
      if (groupData == null) return null;

      return CupGroupModel.fromJson(groupData);
    } on ApiException catch (e) {
      log('Error getting cup group matches: ${e.message}');
      return null;
    } catch (e) {
      log('Error getting cup group matches: $e');
      return null;
    }
  }

  /// Get cup group point table
  /// Matches Android getCupLeagueTable API
  Future<List<CupGroupPointTableEntry>> getCupLeagueTable({
    required String userId,
    required String tournamentId,
    required String groupId,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'tournamentId': tournamentId,
        'groupId': groupId,
      };

      final data = await ApiClient.instance.post(
        ApiConstants.getCupLeagueTable,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return [];

      final status = (response['status'] as num?)?.toInt() ?? 0;
      if (status != 1) return [];

      final tableData = response['table'] as List?;
      if (tableData == null) return [];

      return tableData
          .map((json) =>
              CupGroupPointTableEntry.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ApiException catch (e) {
      log('Error getting cup league table: ${e.message}');
      return [];
    } catch (e) {
      log('Error getting cup league table: $e');
      return [];
    }
  }

  /// Get cup knockout matches
  /// Matches Android getCupKnockMatches API
  Future<List<CupMatchModel>> getCupKnockMatches({
    required String userId,
    required String tournamentId,
    required String roundId,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'tournamentId': tournamentId,
        'roundId': roundId,
      };

      final data = await ApiClient.instance.post(
        ApiConstants.getCupKnockMatches,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return [];

      final status = (response['status'] as num?)?.toInt() ?? 0;
      if (status != 1) return [];

      final matchesData = response['matches'] as List?;
      if (matchesData == null) return [];

      return matchesData
          .map((json) => CupMatchModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ApiException catch (e) {
      log('Error getting cup knockout matches: ${e.message}');
      return [];
    } catch (e) {
      log('Error getting cup knockout matches: $e');
      return [];
    }
  }

  /// Get cup group mode stats (goals, assists, cards, MOM)
  /// Matches Android cupLeagueStatGoals, cupLeagueStatAssists, etc.
  Future<List<CupPlayerStatEntry>> getCupGroupStats({
    required String userId,
    required String tournamentId,
    required String statType, // 'goals', 'assists', 'cards', 'mom'
    String? roundId,
    String? groupId,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'tournamentId': tournamentId,
      };

      if (roundId != null) body['roundId'] = roundId;
      if (groupId != null) body['groupId'] = groupId;

      String endpoint;
      switch (statType) {
        case 'goals':
          endpoint = ApiConstants.cupLeagueStatGoals;
          break;
        case 'assists':
          endpoint = ApiConstants.cupLeagueStatAssists;
          break;
        case 'cards':
          endpoint = ApiConstants.cupLeagueStatCards;
          break;
        case 'mom':
          endpoint = ApiConstants.cupLeagueStatMom;
          break;
        default:
          return [];
      }

      final data = await ApiClient.instance.post(endpoint, body: body);

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return [];

      final status = (response['status'] as num?)?.toInt() ?? 0;
      if (status != 1) return [];

      final statsData = response['stats'] as List?;
      if (statsData == null) return [];

      return statsData
          .map((json) =>
              CupPlayerStatEntry.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ApiException catch (e) {
      log('Error getting cup group stats: ${e.message}');
      return [];
    } catch (e) {
      log('Error getting cup group stats: $e');
      return [];
    }
  }

  /// Get cup match mode stats (knockout stats)
  /// Matches Android cupMatchStatGoals, cupMatchStatAssists, etc.
  Future<List<CupPlayerStatEntry>> getCupMatchStats({
    required String userId,
    required String tournamentId,
    required String statType, // 'goals', 'assists', 'cards', 'mom'
    String? roundId,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'tournamentId': tournamentId,
      };

      if (roundId != null) body['roundId'] = roundId;

      String endpoint;
      switch (statType) {
        case 'goals':
          endpoint = ApiConstants.cupMatchStatGoals;
          break;
        case 'assists':
          endpoint = ApiConstants.cupMatchStatAssists;
          break;
        case 'cards':
          endpoint = ApiConstants.cupMatchStatCards;
          break;
        case 'mom':
          endpoint = ApiConstants.cupMatchStatMom;
          break;
        default:
          return [];
      }

      final data = await ApiClient.instance.post(endpoint, body: body);

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return [];

      final status = (response['status'] as num?)?.toInt() ?? 0;
      if (status != 1) return [];

      final statsData = response['stats'] as List?;
      if (statsData == null) return [];

      return statsData
          .map((json) =>
              CupPlayerStatEntry.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ApiException catch (e) {
      log('Error getting cup match stats: ${e.message}');
      return [];
    } catch (e) {
      log('Error getting cup match stats: $e');
      return [];
    }
  }

  /// Follow/unfollow cup tournament
  /// Matches Android followTournament API (same as league)
  Future<Map<String, dynamic>> followCup({
    required String userId,
    required String tournamentId,
    required String myName,
    String? myImageUrl,
    String? country,
    String? gender,
    int? birthYear,
    bool isPlayer = false,
    bool isCoach = false,
    bool isAdmin = false,
    bool isFan = false,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'tournamentId': tournamentId,
        'myName': myName,
        'followType': 'cup',
        'isPlayer': isPlayer,
        'isCoach': isCoach,
        'isAdmin': isAdmin,
        'isFan': isFan,
      };

      if (myImageUrl != null) body['myImageUrl'] = myImageUrl;
      if (country != null) body['country'] = country;
      if (gender != null) body['gender'] = gender;
      if (birthYear != null) body['birthYear'] = birthYear;

      final data = await ApiClient.instance.post(
        ApiConstants.followTournament,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return {'success': false};

      final status = (response['status'] as num?)?.toInt() ?? 0;
      final isFollow = response['isFollow'] as bool? ?? false;

      return {
        'success': status == 1,
        'isFollow': isFollow,
      };
    } on ApiException catch (e) {
      log('Error following cup: ${e.message}');
      return {'success': false};
    } catch (e) {
      log('Error following cup: $e');
      return {'success': false};
    }
  }

  /// Check if team is eligible for cup
  /// Matches Android checkReqForCup API
  Future<Map<String, dynamic>> checkReqForCup({
    required String userId,
    required String tournamentId,
    required String teamId,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'tournamentId': tournamentId,
        'teamId': teamId,
      };

      final data = await ApiClient.instance.post(
        ApiConstants.checkReqForCup,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return {'eligible': false};

      final status = (response['status'] as num?)?.toInt() ?? 0;
      final eligible = response['eligible'] as bool? ?? false;
      final message = response['message'] as String?;

      return {
        'success': status == 1,
        'eligible': eligible,
        'message': message,
      };
    } on ApiException catch (e) {
      log('Error checking cup eligibility: ${e.message}');
      return {'eligible': false, 'message': e.message};
    } catch (e) {
      log('Error checking cup eligibility: $e');
      return {'eligible': false, 'message': e.toString()};
    }
  }

  /// Get user's teams eligible for cup
  /// Matches Android getMyTeamsForCup API
  Future<List<CupTeamModel>> getMyTeamsForCup({
    required String userId,
    required String tournamentId,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'tournamentId': tournamentId,
      };

      final data = await ApiClient.instance.post(
        ApiConstants.getMyTeamsForCup,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return [];

      final status = (response['status'] as num?)?.toInt() ?? 0;
      if (status != 1) return [];

      final teamsData = response['teams'] as List?;
      if (teamsData == null) return [];

      return teamsData
          .map((json) => CupTeamModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ApiException catch (e) {
      log('Error getting my teams for cup: ${e.message}');
      return [];
    } catch (e) {
      log('Error getting my teams for cup: $e');
      return [];
    }
  }

  /// Request to join cup
  /// Matches Android requestCup API
  Future<bool> requestCup({
    required String userId,
    required String tournamentId,
    required String teamId,
    String? parentId,
    String? teamName,
    String? tmntName,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'tournamentId': tournamentId,
        'teamId': teamId,
      };

      if (parentId != null) body['parentId'] = parentId;
      if (teamName != null) body['teamName'] = teamName;
      if (tmntName != null) body['tmntName'] = tmntName;

      final data = await ApiClient.instance.post(
        ApiConstants.requestCup,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return false;

      final status = (response['status'] as num?)?.toInt() ?? 0;
      final success = response['success'] as bool? ?? false;

      return status == 1 && success;
    } on ApiException catch (e) {
      log('Error requesting to join cup: ${e.message}');
      return false;
    } catch (e) {
      log('Error requesting to join cup: $e');
      return false;
    }
  }

  /// Accept cup join request (Admin only)
  /// Matches Android acceptCupRequest API
  Future<bool> acceptCupRequest({
    required String userId,
    required String tournamentId,
    required String teamId,
    required String requestId,
    required bool accept,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'tournamentId': tournamentId,
        'teamId': teamId,
        'requestId': requestId,
        'accept': accept,
      };

      final data = await ApiClient.instance.post(
        ApiConstants.acceptCupRequest,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return false;

      final status = (response['status'] as num?)?.toInt() ?? 0;
      final success = response['success'] as bool? ?? false;

      return status == 1 && success;
    } on ApiException catch (e) {
      log('Error accepting cup request: ${e.message}');
      return false;
    } catch (e) {
      log('Error accepting cup request: $e');
      return false;
    }
  }
}
