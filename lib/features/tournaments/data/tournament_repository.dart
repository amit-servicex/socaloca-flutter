import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socaloca/shared/models/team_model.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';
import 'tournament_models.dart';

final tournamentRepositoryProvider = Provider<TournamentRepository>((ref) {
  return const TournamentRepository();
});

class TournamentRepository {
  const TournamentRepository();

  /// Get tournaments list (ongoing, upcoming, closed)
  /// Matches Android getVisTmnts API exactly.
  ///
  /// IMPORTANT: status is an INTEGER per Android Params.java:
  ///   ONGOING = 1, UPCOMING = 2, CLOSED = 3
  ///
  /// All filter fields are always sent (empty string when not set),
  /// and ownCountry (user's own country) is required.
  Future<List<TournamentModel>> getTournaments({
    required String userId,
    required int status, // 1=ongoing, 2=upcoming, 3=closed
    String gameType = '',
    String ageGroup = '',
    String gender = '',
    String country = '',
    String confed = '',
    String location = '',
    String visibility = 'local',
    required String ownCountry,
    int start = 0,
    int limit = 10,
    bool isReferee = false,
  }) async {
    try {
      // Send exactly what Android sends — all fields always present
      final body = <String, dynamic>{
        'userId': userId,
        'status': status, // INTEGER: 1, 2, or 3
        'visibility': visibility, // 'local' or 'global'
        'ownCountry': ownCountry, // user's own country — required
        'country': country == ''
            ? 'Ghana'
            : country, // filter country (empty string = all)
        'confed': confed, // confederation filter
        'location': location, // location text search
        'gender': gender.toLowerCase(),
        'ageGroup': ageGroup,
        'gameType': gameType,
        'start': start,
        'limit': limit,
      };

      final data = await ApiClient.instance.post(
        isReferee ? ApiConstants.getRefTmnts : ApiConstants.getVisTmnts,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return [];

      final responseStatus = (response['status'] as num?)?.toInt() ?? 0;
      if (responseStatus != 1) return [];

      final tournamentsData = response['tournaments'] as List?;
      if (tournamentsData == null) return [];

      return tournamentsData
          .map((json) => TournamentModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ApiException catch (e) {
      log('Error getting tournaments: ${e.message}');
      return [];
    } catch (e) {
      log('Error getting tournaments: $e');
      return [];
    }
  }

  /// Get my leagues/cups
  /// Matches Android CommonMyLeaguesCupsFragment — uses getCoachAdminTmntList
  /// Response key is "tmnts" not "tournaments"
  Future<List<TournamentModel>> getMyTournaments({
    required String userId,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
      };

      final data = await ApiClient.instance.post(
        ApiConstants.getCoachAdminTmntList,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return [];

      final status = (response['status'] as num?)?.toInt() ?? 0;
      if (status != 1) return [];

      // Android uses "tmnts" key, not "tournaments"
      final tournamentsData = response['tmnts'] as List?;
      if (tournamentsData == null) return [];

      return tournamentsData
          .map((json) => TournamentModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ApiException catch (e) {
      log('Error getting my tournaments: ${e.message}');
      return [];
    } catch (e) {
      log('Error getting my tournaments: $e');
      return [];
    }
  }

  /// Get tournament details
  /// Matches Android getTmntDetails API
  Future<TournamentModel?> getTournamentDetails({
    required String userId,
    required String tournamentId,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'tournamentId': tournamentId,
      };

      final data = await ApiClient.instance.post(
        ApiConstants.getTmntDetails,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return null;

      final status = (response['status'] as num?)?.toInt() ?? 0;
      if (status != 1) return null;

      final details = response['details'] as Map<String, dynamic>?;
      if (details == null) return null;

      // Parse banners
      List<BannerModel>? banners;
      if (details['banners'] != null && details['banners'] is List) {
        final bannersData = details['banners'] as List;
        banners = bannersData
            .map((json) => BannerModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      // Parse teams
      List<TeamModel>? teams;
      if (response['teams'] != null && response['teams'] is List) {
        final teamsData = response['teams'] as List;
        teams = teamsData.map((json) {
          final t = Map<String, dynamic>.from(json as Map<String, dynamic>);
          t['id'] = t['teamId'] ?? t['_id'] ?? t['id'] ?? '';
          t['name'] = t['teamName'] ?? t['name'] ?? '';
          t['logo'] = t['imageUrl'] ?? t['logo'];
          return TeamModel.fromJson(t);
        }).toList();
      }

      // Parse sponsors
      List<SponsorModel>? sponsors;
      if (response['sponsors'] != null && response['sponsors'] is List) {
        final sponsorsData = response['sponsors'] as List;
        sponsors = sponsorsData
            .map((json) => SponsorModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      // Parse itinerary
      ItineraryModel? itinerary;
      if (response['itinerary'] != null) {
        itinerary = ItineraryModel.fromJson(
            response['itinerary'] as Map<String, dynamic>);
      }

      final tournament = TournamentModel.fromJson(details);
      return tournament.copyWith(
        banners: banners,
        teams: teams,
        sponsors: sponsors,
        itinerary: itinerary,
      );
    } on ApiException catch (e) {
      log('Error getting tournament details: ${e.message}');
      return null;
    } catch (e) {
      log('Error getting tournament details: $e');
      return null;
    }
  }

  /// Follow/unfollow tournament
  /// Matches Android followTournament API
  Future<Map<String, dynamic>> followTournament({
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
        'followType': 'league',
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
      log('Error following tournament: ${e.message}');
      return {'success': false};
    } catch (e) {
      log('Error following tournament: $e');
      return {'success': false};
    }
  }

  /// Get tournament matches (upcoming or played)
  Future<List<TournamentMatchModel>> getTournamentMatches({
    required String userId,
    required String tournamentId,
    bool isUpcoming = true,
    int start = 0,
    int limit = 10,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'tournamentId': tournamentId,
        'start': start,
        'limit': limit,
      };

      final endpoint = isUpcoming
          ? ApiConstants.leagueUpcomingMatches
          : ApiConstants.leaguePlayedMatches;

      final data = await ApiClient.instance.post(endpoint, body: body);

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return [];

      final statusCode = (response['status'] as num?)?.toInt() ?? 0;
      if (statusCode != 1) return [];

      final matchesData = response['matches'] as List?;
      if (matchesData == null) return [];

      return matchesData
          .map((json) => _parseMatch(json as Map<String, dynamic>))
          .toList();
    } on ApiException catch (e) {
      log('Error getting tournament matches: ${e.message}');
      return [];
    } catch (e) {
      log('Error getting tournament matches: $e');
      return [];
    }
  }

  TournamentMatchModel _parseMatch(Map<String, dynamic> m) {
    final teams = m['teams'] as List? ?? [];
    final score = m['score'] as Map<String, dynamic>?;

    String? homeTeamId, homeTeamName, homeTeamLogo;
    String? awayTeamId, awayTeamName, awayTeamLogo;

    final myTeamId = m['myTeamId'] as String?;
    final opponentTeamId = m['opponentTeamId'] as String?;

    homeTeamId = myTeamId;
    homeTeamName = m['myTeamName'] as String?;
    awayTeamId = opponentTeamId;
    awayTeamName = m['opponentTeamName'] as String?;

    for (final t in teams) {
      final team = t as Map<String, dynamic>;
      final tid = (team['teamId'] ?? team['_id']) as String?;
      if (tid == myTeamId) {
        homeTeamLogo = team['imageUrl'] as String?;
      } else if (tid == opponentTeamId) {
        awayTeamLogo = team['imageUrl'] as String?;
      }
    }

    int? homeScore, awayScore;
    if (score != null) {
      homeScore = (score['myGoals'] as num?)?.toInt();
      awayScore = (score['opponentGoals'] as num?)?.toInt();
    }

    return TournamentMatchModel(
      id: m['_id'] as String?,
      matchId: m['matchId'] as String?,
      homeTeamId: homeTeamId,
      homeTeamName: homeTeamName,
      homeTeamLogo: homeTeamLogo,
      awayTeamId: awayTeamId,
      awayTeamName: awayTeamName,
      awayTeamLogo: awayTeamLogo,
      homeScore: homeScore,
      awayScore: awayScore,
      status: m['scoreStatus'] as String? ?? m['status'] as String?,
      matchDate: m['matchDate'] as String?,
      matchDateMs: (m['matchDateTimeGmt'] as num?)?.toInt() ?? 0,
      venue: m['stadiumName'] as String? ??
          m['fieldName'] as String? ??
          m['city'] as String?,
      gameType: m['gameType'] as String?,
      ageGroup: m['ageGroup'] as String?,
    );
  }

  /// Get points table
  Future<List<PointsTableEntry>> getPointsTable({
    required String userId,
    required String tournamentId,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'tournamentId': tournamentId,
      };

      final data = await ApiClient.instance.post(
        ApiConstants.leaguePointTable,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return [];

      final status = (response['status'] as num?)?.toInt() ?? 0;
      if (status != 1) return [];

      final tableData = response['table'] as List?;
      if (tableData == null) return [];

      return tableData
          .map(
              (json) => PointsTableEntry.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ApiException catch (e) {
      log('Error getting points table: ${e.message}');
      return [];
    } catch (e) {
      log('Error getting points table: $e');
      return [];
    }
  }

  /// Get tournament stats (goals, assists, cards, MOM)
  Future<List<PlayerStatEntry>> getTournamentStats({
    required String userId,
    required String tournamentId,
    required String statType, // 'goals', 'assists', 'cards', 'mom'
    int start = 0,
    int limit = 10,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'tournamentId': tournamentId,
        'start': start,
        'limit': limit,
      };

      String endpoint;
      switch (statType) {
        case 'goals':
          endpoint = ApiConstants.leagueStatGoals;
          break;
        case 'assists':
          endpoint = ApiConstants.leagueStatAssists;
          break;
        case 'cards':
          endpoint = ApiConstants.leagueStatCards;
          break;
        case 'mom':
          endpoint = ApiConstants.leagueStatMom;
          break;
        default:
          return [];
      }

      final data = await ApiClient.instance.post(endpoint, body: body);

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return [];

      final status = (response['status'] as num?)?.toInt() ?? 0;
      if (status != 1) return [];

      final statsData = response['players'] as List?;
      if (statsData == null) return [];

      return statsData.map((raw) {
        final map = raw as Map<String, dynamic>;
        final team = map['team'] as Map<String, dynamic>?;

        final firstName = (map['firstName'] as String? ?? '').trim();
        final lastName = (map['lastName'] as String? ?? '').trim();
        final playerName =
            [firstName, lastName].where((s) => s.isNotEmpty).join(' ');

        int count;
        switch (statType) {
          case 'goals':
            count = (map['goalCount'] as num?)?.toInt() ?? 0;
            break;
          case 'assists':
            count = (map['assistCount'] as num?)?.toInt() ?? 0;
            break;
          case 'mom':
            count = (map['momCount'] as num?)?.toInt() ?? 0;
            break;
          default:
            count = 0;
        }

        return PlayerStatEntry.fromJson({
          'userId': map['playerId'],
          'playerName': playerName,
          'playerImage': map['imageUrl'],
          'teamId': team?['teamId'],
          'teamName': team?['teamName'],
          'count': count,
          'yellowCards': (map['yellowCards'] as num?)?.toInt() ??
              (map['yCard'] as num?)?.toInt() ??
              0,
          'redCards': (map['redCards'] as num?)?.toInt() ??
              (map['rCard'] as num?)?.toInt() ??
              0,
        });
      }).toList();
    } on ApiException catch (e) {
      log('Error getting tournament stats: ${e.message}');
      return [];
    } catch (e) {
      log('Error getting tournament stats: $e');
      return [];
    }
  }

  /// Check for tournament invitations
  Future<List<TeamModel>> checkInvites({
    required String userId,
    required String tournamentId,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'tournamentId': tournamentId,
      };

      final data = await ApiClient.instance.post(
        ApiConstants.checkReqForTmnt,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return [];

      final status = (response['status'] as num?)?.toInt() ?? 0;
      if (status != 1) return [];

      final teamsData = response['teams'] as List?;
      if (teamsData == null) return [];

      return teamsData
          .map((json) => TeamModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ApiException catch (e) {
      log('Error checking invites: ${e.message}');
      return [];
    } catch (e) {
      log('Error checking invites: $e');
      return [];
    }
  }

  /// Accept/decline tournament invitation
  Future<bool> acceptDeclineInvite({
    required String userId,
    required String tournamentId,
    required String teamId,
    required bool accept,
    String? parentId,
    String? teamName,
    String? tmntName,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'tournamentId': tournamentId,
        'teamId': teamId,
        'accept': accept,
      };

      if (parentId != null) body['parentId'] = parentId;
      if (teamName != null) body['teamName'] = teamName;
      if (tmntName != null) body['tmntName'] = tmntName;

      final data = await ApiClient.instance.post(
        ApiConstants.acceptTmntRequest,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return false;

      final status = (response['status'] as num?)?.toInt() ?? 0;
      final success = response['success'] as bool? ?? false;

      return status == 1 && success;
    } on ApiException catch (e) {
      log('Error accepting/declining invite: ${e.message}');
      return false;
    } catch (e) {
      log('Error accepting/declining invite: $e');
      return false;
    }
  }

  /// Get user's teams eligible for tournament
  Future<List<TeamModel>> getMyTeamsForTournament({
    required String userId,
    required String tournamentId,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'tournamentId': tournamentId,
      };

      final data = await ApiClient.instance.post(
        ApiConstants.getMyTeamsForTmnt,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return [];

      final status = (response['status'] as num?)?.toInt() ?? 0;
      if (status != 1) return [];

      final teamsData = response['teams'] as List?;
      if (teamsData == null) return [];

      return teamsData
          .map((json) => TeamModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ApiException catch (e) {
      log('Error getting my teams: ${e.message}');
      return [];
    } catch (e) {
      log('Error getting my teams: $e');
      return [];
    }
  }

  /// Request to join tournament
  Future<bool> requestToJoinTournament({
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
        ApiConstants.requestTmnt,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return false;

      final status = (response['status'] as num?)?.toInt() ?? 0;
      final success = response['success'] as bool? ?? false;

      return status == 1 && success;
    } on ApiException catch (e) {
      log('Error requesting to join tournament: ${e.message}');
      return false;
    } catch (e) {
      log('Error requesting to join tournament: $e');
      return false;
    }
  }

  /// Get teams that can withdraw from tournaments
  /// Matches Android getMyTmntJoinedTeams API
  Future<List<TeamModel>> getWithdrawableTeams({
    required String userId,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
      };

      final data = await ApiClient.instance.post(
        ApiConstants.getWithdrawTmntTeams,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return [];

      final status = (response['status'] as num?)?.toInt() ?? 0;
      if (status != 1) return [];

      final teamsData = response['teams'] as List?;
      if (teamsData == null) return [];

      return teamsData
          .map((json) => TeamModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ApiException catch (e) {
      log('Error getting withdrawable teams: ${e.message}');
      return [];
    } catch (e) {
      log('Error getting withdrawable teams: $e');
      return [];
    }
  }

  /// Withdraw team from tournament
  /// Matches Android withdrawTeam API
  Future<bool> withdrawTeam({
    required String userId,
    required String tournamentId,
    required String teamId,
    String? reason,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'tournamentId': tournamentId,
        'teamId': teamId,
      };

      if (reason != null) body['reason'] = reason;

      final data = await ApiClient.instance.post(
        ApiConstants.withdrawTeam,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return false;

      final status = (response['status'] as num?)?.toInt() ?? 0;
      final success = response['success'] as bool? ?? false;

      return status == 1 && success;
    } on ApiException catch (e) {
      log('Error withdrawing team: ${e.message}');
      return false;
    } catch (e) {
      log('Error withdrawing team: $e');
      return false;
    }
  }

  /// Get tournament invitations for user's teams
  /// Custom method to fetch pending invitations
  Future<List<Map<String, dynamic>>> getTournamentInvitations({
    required String userId,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
      };

      final data = await ApiClient.instance.post(
        ApiConstants.getTmntInvitations,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return [];

      final status = (response['status'] as num?)?.toInt() ?? 0;
      if (status != 1) return [];

      final invitationsData = response['invitations'] as List?;
      if (invitationsData == null) return [];

      return invitationsData
          .map((json) => json as Map<String, dynamic>)
          .toList();
    } on ApiException catch (e) {
      log('Error getting tournament invitations: ${e.message}');
      return [];
    } catch (e) {
      log('Error getting tournament invitations: $e');
      return [];
    }
  }

  /// Respond to tournament invitation
  /// Custom method to accept/decline invitation
  Future<bool> respondToInvitation({
    required String userId,
    required String tournamentId,
    required String teamId,
    required String invitationId,
    required bool accept,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'tournamentId': tournamentId,
        'teamId': teamId,
        'invitationId': invitationId,
        'accept': accept,
      };

      final data = await ApiClient.instance.post(
        ApiConstants.respondTmntInvitation,
        body: body,
      );

      final response = data['response'] as Map<String, dynamic>?;
      if (response == null) return false;

      final status = (response['status'] as num?)?.toInt() ?? 0;
      final success = response['success'] as bool? ?? false;

      return status == 1 && success;
    } on ApiException catch (e) {
      log('Error responding to invitation: ${e.message}');
      return false;
    } catch (e) {
      log('Error responding to invitation: $e');
      return false;
    }
  }
}
