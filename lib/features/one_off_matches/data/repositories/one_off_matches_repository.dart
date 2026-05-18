import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../tournaments/data/models/match_management_models.dart';
import '../../../tournaments/data/tournament_models.dart';

/// Repository for One-Off Matches (standalone matches not part of tournaments)
class OneOffMatchesRepository {
  /// Get today's featured match
  Future<TournamentMatchModel?> getTodaysMatch({
    required String userId,
    required String country,
    required String dateToday,
  }) async {
    try {
      print(
          '📡 [OneOff API] Calling getFanTodaysMatches with date: $dateToday');

      final response = await ApiClient.instance.post(
        ApiConstants.getFanTodaysMatches,
        body: {
          'userId': userId,
          'country': country,
          'dateToday': dateToday,
          'start': 0,
          'limit': 1,
        },
      );

      print('📡 [OneOff API] Response keys: ${response.keys.toList()}');

      // Response is nested: {"response": {"status": 1, "matches": [...]}}
      final data = response['response'] as Map<String, dynamic>?;
      if (data != null && data['status'] == 1 && data['matches'] != null) {
        final matches = data['matches'] as List;
        print('📡 [OneOff API] Found ${matches.length} today\'s matches');
        if (matches.isNotEmpty) {
          final match = _parseMatch(matches[0]);
          print(
              '✅ [OneOff API] Parsed match: ${match.homeTeamName} vs ${match.awayTeamName}');
          return match;
        }
      }
      print('⚠️ [OneOff API] No today\'s matches found');
      return null;
    } catch (e, stack) {
      print('❌ [OneOff API] Error fetching today\'s match: $e');
      print('Stack: $stack');
      return null;
    }
  }

  /// Get upcoming matches
  Future<List<TournamentMatchModel>> getUpcomingMatches({
    required String userId,
    required String country,
    int start = 0,
    int limit = 3,
  }) async {
    try {
      print('📡 [OneOff API] Calling getFanUpcomingMatches');

      final response = await ApiClient.instance.post(
        ApiConstants.getFanUpcomingMatches,
        body: {
          'userId': userId,
          'country': country,
          'start': start,
          'limit': limit,
        },
      );

      print(
          '📡 [OneOff API] Upcoming response keys: ${response.keys.toList()}');

      // Response is nested: {"response": {"status": 1, "matches": [...]}}
      final data = response['response'] as Map<String, dynamic>?;
      if (data != null && data['status'] == 1 && data['matches'] != null) {
        final matches = data['matches'] as List;
        print('📡 [OneOff API] Found ${matches.length} upcoming matches');
        final parsed = matches.map((m) => _parseMatch(m)).toList();
        print('✅ [OneOff API] Parsed ${parsed.length} upcoming matches');
        return parsed;
      }
      print('⚠️ [OneOff API] No upcoming matches found');
      return [];
    } catch (e, stack) {
      print('❌ [OneOff API] Error fetching upcoming matches: $e');
      print('Stack: $stack');
      return [];
    }
  }

  /// Get recent/played matches
  Future<List<TournamentMatchModel>> getPlayedMatches({
    required String userId,
    required String country,
    int start = 0,
    int limit = 3,
  }) async {
    try {
      print('📡 [OneOff API] Calling getFanPlayedMatches');

      final response = await ApiClient.instance.post(
        ApiConstants.getFanPlayedMatches,
        body: {
          'userId': userId,
          'country': country,
          'start': start,
          'limit': limit,
        },
      );

      print('📡 [OneOff API] Played response keys: ${response.keys.toList()}');

      // Response is nested: {"response": {"status": 1, "matches": [...]}}
      final data = response['response'] as Map<String, dynamic>?;
      if (data != null && data['status'] == 1 && data['matches'] != null) {
        final matches = data['matches'] as List;
        print('📡 [OneOff API] Found ${matches.length} played matches');
        final parsed = matches.map((m) => _parseMatch(m)).toList();
        print('✅ [OneOff API] Parsed ${parsed.length} played matches');
        return parsed;
      }
      print('⚠️ [OneOff API] No played matches found');
      return [];
    } catch (e, stack) {
      print('❌ [OneOff API] Error fetching played matches: $e');
      print('Stack: $stack');
      return [];
    }
  }

  /// Parse match from API response
  TournamentMatchModel _parseMatch(dynamic matchData) {
    print('📝 [OneOff Parse] Parsing match: ${matchData['matchId']}');

    final teams = matchData['teams'] as List? ?? [];
    final score = matchData['score'] as Map<String, dynamic>?;

    String? homeTeamId, homeTeamName, homeTeamLogo;
    String? awayTeamId, awayTeamName, awayTeamLogo;
    int? homeScore, awayScore;

    // Parse teams from teams array
    if (teams.length >= 2) {
      final team1 = teams[0] as Map<String, dynamic>;
      final team2 = teams[1] as Map<String, dynamic>;

      homeTeamId = team1['teamId'] ?? team1['_id'];
      homeTeamName = team1['teamName'];
      homeTeamLogo = team1['imageUrl'];

      awayTeamId = team2['teamId'] ?? team2['_id'];
      awayTeamName = team2['teamName'];
      awayTeamLogo = team2['imageUrl'];
    }

    // Parse score if available
    if (score != null) {
      homeScore = score['myGoals'] as int?;
      awayScore = score['opponentGoals'] as int?;
      print('📝 [OneOff Parse] Score: $homeScore - $awayScore');
    }

    final match = TournamentMatchModel(
      id: matchData['_id'],
      matchId: matchData['matchId'],
      homeTeamId: homeTeamId,
      homeTeamName: homeTeamName,
      homeTeamLogo: homeTeamLogo,
      awayTeamId: awayTeamId,
      awayTeamName: awayTeamName,
      awayTeamLogo: awayTeamLogo,
      homeScore: homeScore,
      awayScore: awayScore,
      status: matchData['status'],
      matchDate: matchData['matchDate'],
      matchDateMs: matchData['matchDateTimeGmt'] ?? 0,
      venue: matchData['stadiumName'],
      gameType: matchData['gameType'],
      ageGroup: matchData['ageGroup'],
    );

    print(
        '✅ [OneOff Parse] Parsed: ${match.homeTeamName} vs ${match.awayTeamName}');
    return match;
  }
}

/// Provider for OneOffMatchesRepository
final oneOffMatchesRepositoryProvider =
    Provider<OneOffMatchesRepository>((ref) {
  return OneOffMatchesRepository();
});
