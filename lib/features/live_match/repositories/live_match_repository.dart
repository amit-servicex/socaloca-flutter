import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/storage/storage_service.dart';
import '../models/live_match_models.dart';

class LiveMatchRepository {
  String get _userId => StorageService.userId ?? '';

  // ─── Player/Common live match list ────────────────────────────────────────

  Future<List<LiveMatchListItem>> getPlayerLiveMatches({
    String? tournamentId,
    String? country,
    int start = 0,
    int limit = 10,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.getLiveMatchList,
      body: {
        'userId': _userId,
        'tournamentId': tournamentId ?? '',
        'country': country ?? '',
        'start': start,
        'limit': limit,
      },
    );
    final inner = _inner(response);
    if (inner['status'] != 1) return [];
    final List<dynamic> dataArr = inner['data'] as List? ?? [];
    if (dataArr.isEmpty) return [];

    final List<LiveMatchListItem> items = [];

    // Detect grouped format: [{tournamentId, tournamentName, matches:[...]}, ...]
    final firstEl = dataArr.first;
    final isGrouped = firstEl is Map && firstEl.containsKey('matches');

    if (isGrouped) {
      for (final tournObj in dataArr) {
        final t = tournObj as Map<String, dynamic>;
        final tmntId = t['tournamentId']?.toString() ?? '';
        final tmntName = t['tournamentName']?.toString();
        final tmntLogo = t['tournamentLogo']?.toString();
        final tmntCountry = t['country']?.toString();
        final matches = t['matches'] as List? ?? [];

        final tournamentItems = <LiveMatchListItem>[];
        for (final matchObj in matches) {
          final m = Map<String, dynamic>.from(matchObj as Map);
          m['tournamentId'] ??= tmntId;
          m['tmntName'] ??= tmntName;
          m['tournamentLogo'] ??= tmntLogo;
          m['tournamentCountry'] ??= tmntCountry;
          tournamentItems.add(LiveMatchListItem.fromJson(m));
        }
        // Sort within each tournament group descending by time
        tournamentItems.sort((a, b) =>
            (b.matchDateTimeGmt ?? 0).compareTo(a.matchDateTimeGmt ?? 0));
        items.addAll(tournamentItems);
      }
    } else {
      // Flat format fallback
      for (final e in dataArr) {
        items.add(LiveMatchListItem.fromJson(e as Map<String, dynamic>));
      }
      items.sort((a, b) =>
          (b.matchDateTimeGmt ?? 0).compareTo(a.matchDateTimeGmt ?? 0));
    }

    return _markUniqueTournaments(items);
  }

  // ─── Tournament dropdown (shared with referee) ────────────────────────────

  Future<List<Map<String, String>>> getTournamentDropdown() async {
    final response = await ApiClient.instance.post(
      ApiConstants.getRefTmntsDrop,
      body: {'userId': _userId},
    );
    final inner = _inner(response);
    if (inner['status'] != 1) return [];
    final List<dynamic> raw = inner['tournaments'] as List? ?? [];
    return raw.map((e) {
      final m = e as Map<String, dynamic>;
      return {
        'tournamentId': m['tournamentId']?.toString() ?? '',
        'tournamentName': m['tournamentName']?.toString() ?? '',
      };
    }).toList();
  }

  // ─── Country dropdown ─────────────────────────────────────────────────────
  // Android uses GetApiRequest (HTTP GET, no body) for this endpoint.

  Future<List<String>> getCountryDropdown() async {
    final response = await ApiClient.instance.get(
      ApiConstants.getLiveMtchCountries,
    );
    final inner = _inner(response);
    if (inner['status'] != 1) return [];
    final List<dynamic> raw = inner['countries'] as List? ?? [];
    return raw
        .map((e) => e?.toString() ?? '')
        .where((s) => s.isNotEmpty)
        .toList();
  }

  // ─── Live match details (all roles) ──────────────────────────────────────

  Future<LiveMatchDetail?> getLiveMatchDetail({
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
    final inner = _inner(response);
    if (inner['status'] != 1) return null;
    return LiveMatchDetail.fromJson(matchId, tournamentId, inner);
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────

  Map<String, dynamic> _inner(Map<String, dynamic> raw) {
    if (raw.containsKey('response') && raw['response'] is Map) {
      return raw['response'] as Map<String, dynamic>;
    }
    return raw;
  }

  List<LiveMatchListItem> _markUniqueTournaments(
      List<LiveMatchListItem> items) {
    String prev = '';
    return items.map((item) {
      final isUnique = item.tournamentId != prev;
      prev = item.tournamentId;
      return LiveMatchListItem(
        matchId: item.matchId,
        tournamentId: item.tournamentId,
        tournamentName: item.tournamentName,
        tournamentLogoUrl: item.tournamentLogoUrl,
        tournamentCountry: item.tournamentCountry,
        matchDateTimeGmt: item.matchDateTimeGmt,
        state: item.state,
        homeTeam: item.homeTeam,
        awayTeam: item.awayTeam,
        homeGoals: item.homeGoals,
        awayGoals: item.awayGoals,
        uniqueTournamentId: isUnique,
      );
    }).toList();
  }
}
