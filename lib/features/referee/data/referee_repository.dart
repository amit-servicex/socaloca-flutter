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
    final List<dynamic> raw = resp['matches'] as List? ?? [];
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
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.getRefMatchList,
      body: {
        'userId': _userId,
        'tournamentId': tournamentId ?? '',
        'start': start,
        'limit': 10,
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    if (resp['status'] != 1) return [];
    final List<dynamic> raw = resp['matches'] as List? ?? [];
    return raw
        .map((e) => RefereeMatchModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ─── Live Matches tab ─────────────────────────────────────────────────────

  Future<List<RefereeMatchModel>> getLiveMatches({
    String? tournamentId,
    int start = 0,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.getRefLiveList,
      body: {
        'userId': _userId,
        'tournamentId': tournamentId ?? '',
        'start': start,
        'limit': 10,
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    if (resp['status'] != 1) return [];
    final List<dynamic> raw = resp['matches'] as List? ?? [];
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
    int penaltyScore = 0,
    int extraTimeScore = 0,
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
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.saveRefLiveMtchData,
      body: {
        'userId': _userId,
        'matchId': matchId,
        'tournamentId': tournamentId,
        'entry': entry,
        'state': state,
        'keyVals': keyVals,
      },
    );
    final resp = response['response'] as Map<String, dynamic>? ?? {};
    return resp['status'] == 1;
  }
}
