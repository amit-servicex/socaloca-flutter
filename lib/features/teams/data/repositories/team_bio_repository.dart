import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/storage_service.dart';
import '../models/team_bio_model.dart';
import '../models/team_match_model.dart';

/// Repository for team bio related API calls
class TeamBioRepository {
  /// Get team bio details
  Future<TeamBioModel> getTeamBio({required String teamId}) async {
    try {
      print('🔍 Fetching team bio for teamId: $teamId');

      final response = await ApiClient.instance.post(
        ApiConstants.getTeamBio,
        body: {
          'teamId': teamId,
        },
      );

      if (response['response']['status'] != 1) {
        print('❌ API returned status: ${response['response']['status']}');
        throw Exception('Failed to load team bio');
      }

      if (response['response']['teamBio'] == null) {
        print('❌ No teamBio field in response');
        throw Exception('No team bio data available');
      }

      final teamBioData =
          response['response']['teamBio'] as Map<String, dynamic>;
      print('📋 Team bio data: $teamBioData');

      // Parse teamBioData to TeamBioModel first
      final teamBio = TeamBioModel.fromJson(teamBioData);

      // Fetch recent matches separately
      final recentMatches = await getTeamRecentMatches(teamId: teamId);

      // Return a new TeamBioModel with matches added using copyWith
      return teamBio.copyWith(recentMatches: recentMatches);
    } catch (e, stackTrace) {
      print('❌ Error in getTeamBio: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Get team recent matches
  Future<List<TeamMatchModel>> getTeamRecentMatches(
      {required String teamId}) async {
    try {
      print('🔍 Fetching recent matches for teamId: $teamId');

      final userId = StorageService.userId;
      if (userId == null || userId.isEmpty) {
        print('⚠️ User not logged in, skipping recent matches');
        return [];
      }

      final response = await ApiClient.instance.post(
        ApiConstants.getTeamRecentMatches,
        body: {
          'userId': userId,
          'teamId': teamId,
        },
      );

      print('🔍 Recent Matches API Response: $response');

      // Android uses structure: { status: 1, matches: [...] }
      if (response['response']['status'] != 1) {
        print('❌ API returned status: ${response['response']['status']}');
        return [];
      }

      if (response['response']['matches'] == null) {
        print('ℹ️ No matches field in response');
        return [];
      }

      final matchesData = response['response']['matches'] as List;
      print('✅ Found ${matchesData.length} recent matches');

      if (matchesData.isEmpty) {
        return [];
      }

      final matches = <TeamMatchModel>[];
      for (var i = 0; i < matchesData.length; i++) {
        try {
          final matchJson = matchesData[i] as Map<String, dynamic>;

          // Extract teams and score arrays
          final teams = matchJson['teams'] as List?;
          final score = matchJson['score'] as Map<String, dynamic>?;

          // Build simplified match object
          final simplifiedMatch = <String, dynamic>{
            'matchId': matchJson['matchId'],
            'matchDate': matchJson['matchDate'],
            'matchTime': matchJson['matchTime'],
            'gameType': matchJson['gameType'],
            'country': matchJson['country'],
            'city': matchJson['city'],
            'teams': teams ?? [],
            'score': score,
          };

          final match = TeamMatchModel.fromJson(simplifiedMatch);
          matches.add(match);
        } catch (e, stackTrace) {
          print('❌ Error parsing match at index $i: $e');
          print('Match data: ${matchesData[i]}');
          print('Stack trace: $stackTrace');
        }
      }

      print('✅ Successfully parsed ${matches.length} matches');
      return matches;
    } catch (e, stackTrace) {
      print('❌ Error in getTeamRecentMatches: $e');
      print('Stack trace: $stackTrace');
      return []; // Return empty list on error, don't fail the whole bio
    }
  }
}
