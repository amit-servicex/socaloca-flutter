import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/storage/storage_service.dart';
import 'models/referee_bio_model.dart';
import 'models/referee_match_model.dart';
import 'models/referee_tournament_model.dart';

class RefereeRepository {
  String get _userId => StorageService.userId ?? '';

  // ─── Tournament tab ────────────────────────────────────────────────────────

  Future<List<RefereeTournamentModel>> getTournaments({int start = 0}) async {
    final userMap = StorageService.currentUser ?? {};
    final ownCountry = userMap['country']?.toString() ?? '';
    final gender =
        userMap['gender']?.toString() ?? userMap['type']?.toString() ?? '';

    final response = await ApiClient.instance.post(
      ApiConstants.getRefTmnts,
      body: {
        'userId': _userId,
        'country': '',
        'confed': '',
        'location': '',
        'gender': gender,
        'ageGroup': '',
        'gameType': '',
        'start': start,
        'limit': 10,
        'status': '',
        'ownCountry': ownCountry,
        'visibility': 'GLOBAL',
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    if (resp['status'] != 1) return [];
    final List<dynamic> raw = (resp['ongoingTournaments'] as List? ?? []) +
        (resp['upcomingTournaments'] as List? ?? []) +
        (resp['closedTournaments'] as List? ?? []);
    return raw
        .map((e) => RefereeTournamentModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ─── Shared dropdown helpers ───────────────────────────────────────────────

  Future<List<TournamentDropdownItem>> getMatchesTournamentDropdown() async {
    final response = await ApiClient.instance.post(
      ApiConstants.getRefTmntsDrop,
      body: {'userId': _userId},
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    if (resp['status'] != 1) return [];
    final List<dynamic> raw = resp['tournaments'] as List? ?? [];
    return raw
        .map((e) => TournamentDropdownItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<TournamentDropdownItem>> getRequestsTournamentDropdown() async {
    final response = await ApiClient.instance.post(
      ApiConstants.getRefTmntsReqDrop,
      body: {'userId': _userId},
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    if (resp['status'] != 1) return [];
    final List<dynamic> raw = resp['tournaments'] as List? ?? [];
    return raw
        .map((e) => TournamentDropdownItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ─── My Requests tab ──────────────────────────────────────────────────────

  Future<List<RefereeMatchModel>> getRequests({
    String? tournamentId,
    int start = 0,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.getRefMatchReqs,
      body: {
        'userId': _userId,
        'tournamentId': tournamentId ?? '',
        'start': start,
        'limit': 10,
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    if (resp['status'] != 1) return [];
    final List<dynamic> raw = resp['matchSet'] as List? ?? [];
    return raw
        .map((e) => RefereeMatchModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<bool> respondToRequest({
    required String matchId,
    required String tournamentId,
    required bool accept,
    String reason = '',
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.respondRefMatch,
      body: {
        'matchId': matchId,
        'tournamentId': tournamentId,
        'accept': accept ? 1 : 0,
        'reason': reason,
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    return resp['status'] == 1;
  }

  // ─── My Matches tab ───────────────────────────────────────────────────────

  Future<List<RefereeMatchModel>> getMatches({
    String? tournamentId,
    int start = 0,
    int limit = 10,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.getRefMatchList,
      body: {
        'userId': _userId,
        'tournamentId': tournamentId ?? '',
        'start': start,
        'limit': limit,
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    if (resp['status'] != 1) return [];
    final List<dynamic> raw = resp['matchSet'] as List? ?? [];
    return raw
        .map((e) => RefereeMatchModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ─── Live Matches tab ─────────────────────────────────────────────────────

  Future<List<RefereeMatchModel>> getLiveMatches({
    String? tournamentId,
    int start = 0,
    int limit = 10,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.getRefLiveList,
      body: {
        'userId': _userId,
        'tournamentId': tournamentId ?? '',
        'start': start,
        'limit': limit,
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    if (resp['status'] != 1) return [];
    final List<dynamic> raw = resp['matchSet'] as List? ?? [];
    return raw
        .map((e) => RefereeMatchModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ─── My Bio tab ───────────────────────────────────────────────────────────

  Future<RefereeBioModel?> getRefBio() async {
    final response = await ApiClient.instance.post(
      ApiConstants.getRefBio,
      body: {'userId': _userId},
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    if (resp['status'] != 1) return null;
    final data = resp['playerBio'] ?? resp['refBio'] ?? resp['bio'];
    if (data == null) return null;
    return RefereeBioModel.fromJson(data as Map<String, dynamic>);
  }

  Future<List<RefereeActivityModel>> getActivities({int start = 0}) async {
    final response = await ApiClient.instance.post(
      ApiConstants.getRefMtchActList,
      body: {
        'userId': _userId,
        'refereeId': _userId,
        'year': DateTime.now().year,
        'start': start,
        'limit': 10,
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    if (resp['status'] != 1) return [];
    final List<dynamic> raw = resp['activities'] as List? ?? [];
    return raw
        .map((e) => RefereeActivityModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ─── Manage Match (Phase 8) ───────────────────────────────────────────────

  Future<Map<String, dynamic>?> getManageMatchDetails({
    required String matchId,
    required String tournamentId,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.getRefTmntMtchDtl,
      body: {
        'userId': _userId,
        'matchId': matchId,
        'tournamentId': tournamentId,
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    if (resp['status'] != 1) return null;
    return resp;
  }

  Future<bool> saveMatchScore({
    required String matchId,
    required String tournamentId,
    required int teamAScore,
    required int teamBScore,
    bool penaltyScore = false,
    bool extraTimeScore = false,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.saveRefMatchScore,
      body: {
        'userId': _userId,
        'matchId': matchId,
        'tournamentId': tournamentId,
        'myGoals': teamAScore,
        'opponentGoals': teamBScore,
        'penaltyScore': penaltyScore,
        'extraTimeScore': extraTimeScore,
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    return resp['status'] == 1;
  }

  Future<bool> saveExtraTimeScore({
    required String matchId,
    required int teamAScore,
    required int teamBScore,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.saveRefMtchExtScore,
      body: {
        'matchId': matchId,
        'myGoals': teamAScore,
        'opponentGoals': teamBScore,
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    return resp['status'] == 1;
  }

  Future<bool> savePenaltyScore({
    required String matchId,
    required int teamAScore,
    required int teamBScore,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.saveRefMtchPenaltyScore,
      body: {
        'matchId': matchId,
        'myGoals': teamAScore,
        'opponentGoals': teamBScore,
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    return resp['status'] == 1;
  }

  Future<bool> saveMatchGoals({
    required String matchId,
    required String tournamentId,
    required String matchType,
    required List<Map<String, dynamic>> goals,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.refSaveMatchGoals,
      body: {
        'tournamentId': tournamentId,
        'userId': _userId,
        'matchId': matchId,
        'matchType': matchType,
        'goals': goals
            .map((goal) => {
                  ...goal,
                  if (!goal.containsKey('addedBy')) 'addedBy': _userId,
                })
            .toList(),
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    return resp['status'] == 1;
  }

  Future<bool> saveMatchCards({
    required String matchId,
    required String tournamentId,
    required String matchType,
    required List<Map<String, dynamic>> cards,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.saveRefMtchCards,
      body: {
        'tournamentId': tournamentId,
        'userId': _userId,
        'matchId': matchId,
        'matchType': matchType,
        'cards': cards
            .map((card) => {
                  ...card,
                  'matchId': matchId,
                  if (!card.containsKey('addedBy')) 'addedBy': _userId,
                })
            .toList(),
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    return resp['status'] == 1;
  }

  Future<bool> saveMatchMgmt({
    required String matchId,
    required String tournamentId,
    required Map<String, dynamic> data,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.saveRefMatchMgmt,
      body: {
        'userId': _userId,
        'matchId': matchId,
        'tournamentId': tournamentId,
        ...data,
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    return resp['status'] == 1;
  }

  Future<bool> savePlayerOfTheMatch({
    required String matchId,
    required String tournamentId,
    required String matchType,
    required String mvpTeamId,
    required String mvpPlayerId,
    required String mvpPlayerName,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.saveRefMatchMvp,
      body: {
        'tournamentId': tournamentId,
        'userId': _userId,
        'matchId': matchId,
        'matchType': matchType,
        'mvpTeamId': mvpTeamId,
        'mvpPlayerId': mvpPlayerId,
        'mvpPlayerName': mvpPlayerName,
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    return resp['status'] == 1;
  }

  Future<bool> saveCleanSheet({
    required String matchId,
    required String tournamentId,
    String? myTeamCleanSheet,
    String? oppoTeamCleanSheet,
  }) async {
    final body = <String, dynamic>{
      'tournamentId': tournamentId,
      'userId': _userId,
      'matchId': matchId,
    };
    if (myTeamCleanSheet?.isNotEmpty == true) {
      body['myTeamCleanSheet'] = myTeamCleanSheet;
    }
    if (oppoTeamCleanSheet?.isNotEmpty == true) {
      body['oppoTeamCleanSheet'] = oppoTeamCleanSheet;
    }
    final response = await ApiClient.instance.post(
      ApiConstants.refMatchCleanSheet,
      body: body,
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    return resp['status'] == 1;
  }

  Future<bool> saveCoachManager({
    required String matchId,
    Map<String, dynamic>? myCoach,
    Map<String, dynamic>? myManager,
    Map<String, dynamic>? oppoCoach,
    Map<String, dynamic>? oppoManager,
  }) async {
    final body = <String, dynamic>{'matchId': matchId};
    if (myCoach != null) body['myCoach'] = myCoach;
    if (myManager != null) body['myManager'] = myManager;
    if (oppoCoach != null) body['oppoCoach'] = oppoCoach;
    if (oppoManager != null) body['oppoManager'] = oppoManager;
    final response = await ApiClient.instance.post(
      ApiConstants.saveRefMatchMgmt,
      body: body,
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    return resp['status'] == 1;
  }

  Future<bool> saveMatchOfficials({
    required String matchId,
    required List<Map<String, dynamic>> myOfficials,
    required List<Map<String, dynamic>> oppoOfficials,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.saveMatchOfcl,
      body: {
        'userId': _userId,
        'matchId': matchId,
        'myOfficials': myOfficials,
        'oppoOfficials': oppoOfficials,
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    return resp['status'] == 1;
  }

  Future<bool> saveMatchSquad({
    required String matchId,
    required String tournamentId,
    required List<Map<String, dynamic>> myPlayers,
    required List<Map<String, dynamic>> opponentPlayers,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.saveRefMtchSquad,
      body: {
        'tournamentId': tournamentId,
        'userId': _userId,
        'matchId': matchId,
        'myPlayers': myPlayers,
        'opponentPlayers': opponentPlayers,
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    return resp['status'] == 1;
  }

  Future<bool> saveSubstitutes({
    required String matchId,
    required List<Map<String, dynamic>> players,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.saveRefMatchSubs,
      body: {
        'matchId': matchId,
        'players': players,
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    return resp['status'] == 1;
  }

  Future<bool> saveMatchIncident({
    required String matchId,
    required String desc,
    String commIncident = '',
  }) async {
    final body = <String, dynamic>{
      'userId': _userId,
      'matchId': matchId,
      'desc': desc,
    };
    if (commIncident.isNotEmpty) {
      body['commIncident'] = commIncident;
    }
    final response = await ApiClient.instance.post(
      ApiConstants.saveRefMatchIncident,
      body: body,
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    return resp['status'] == 1;
  }

  Future<bool> saveMatchPhotos({
    required String matchId,
    required String parentId,
    required List<Map<String, dynamic>> photos,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.saveRefMtchPhotos,
      body: {
        'userId': _userId,
        'matchId': matchId,
        'parentId': parentId,
        'photos': photos,
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    return resp['status'] == 1;
  }

  Future<bool> saveMatchHighlights({
    required String matchId,
    required String parentId,
    required String matchType,
    required List<Map<String, dynamic>> videos,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.saveRefMtchVideos,
      body: {
        'userId': _userId,
        'matchId': matchId,
        'parentId': parentId,
        'matchType': matchType,
        'videos': videos,
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    return resp['status'] == 1;
  }

  Future<bool> saveMatchVideos({
    required String matchId,
    required String parentId,
    required String matchType,
    required List<Map<String, dynamic>> videos,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.saveRefMtchBigVideo,
      body: {
        'userId': _userId,
        'matchId': matchId,
        'parentId': parentId,
        'matchType': matchType,
        'videos': videos,
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    return resp['status'] == 1;
  }

  Future<bool> publishMatchVideos({
    required String matchId,
    required String parentId,
    required String matchType,
    required List<Map<String, dynamic>> videos,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.pubRefMtchBigVideo,
      body: {
        'userId': _userId,
        'matchId': matchId,
        'parentId': parentId,
        'matchType': _publishedMatchType(matchType),
        'videos': videos,
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    return resp['status'] == 1;
  }

  String _publishedMatchType(String matchType) {
    if (matchType == 'tournament') return 'leagueMatch';
    if (matchType == 'cupLeague') return 'cupGroup';
    if (matchType == 'cupMatch') return 'cupKnock';
    return '';
  }

  // ─── Live Match Update (Phase 9) ─────────────────────────────────────────

  Future<Map<String, dynamic>?> getLiveMatchData({
    required String matchId,
    required String tournamentId,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.getRefLiveMtchData,
      body: {
        'userId': _userId,
        'matchId': matchId,
        'tournamentId': tournamentId,
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    if (resp['status'] != 1) return null;
    return resp;
  }

  Future<bool> saveLiveMatchData({
    required String matchId,
    required String tournamentId,
    required String entry,
    required String state,
    Map<String, dynamic> keyVals = const {},
    String? listKey,
    List<Map<String, dynamic>> listVal = const [],
  }) async {
    final body = <String, dynamic>{
      'userId': _userId,
      'matchId': matchId,
      'tournamentId': tournamentId,
      'entry': entry,
      'state': state,
      'keyVals': keyVals,
    };
    if (listKey != null && listKey.isNotEmpty) {
      body['listKey'] = listKey;
      body['listVal'] = listVal;
    }
    final response = await ApiClient.instance.post(
      ApiConstants.saveRefLiveMtchData,
      body: body,
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    return resp['status'] == 1;
  }

  Future<bool> saveLiveMatchState({
    required String matchId,
    required String tournamentId,
    required String state,
    Map<String, dynamic> keyVals = const {},
  }) {
    return saveLiveMatchData(
      matchId: matchId,
      tournamentId: tournamentId,
      entry: 'state',
      state: state,
      keyVals: keyVals,
    );
  }

  Future<bool> matchSquadAlert({
    required String teamId,
    required String opponentTeamId,
    required String tournamentId,
    required String matchId,
  }) async {
    try {
      final resp = await ApiClient.instance.post(
        ApiConstants.mtchSquadAlert,
        body: {
          'teamId': teamId,
          'opponentTeamId': opponentTeamId,
          'tournamentId': tournamentId,
          'userId': _userId,
          'matchId': matchId,
        },
      );
      return resp['success'] == true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> savePenaltyAttempts({
    required String matchId,
    required String tournamentId,
    required String matchType,
    required List<Map<String, dynamic>> goals,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.saveRefMtchPenaltyGoals,
      body: {
        'tournamentId': tournamentId,
        'userId': _userId,
        'matchId': matchId,
        'matchType': matchType,
        'goals': goals
            .map((g) => {
                  ...g,
                  if (!g.containsKey('addedBy')) 'addedBy': _userId,
                })
            .toList(),
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    return resp['status'] == 1;
  }
}
