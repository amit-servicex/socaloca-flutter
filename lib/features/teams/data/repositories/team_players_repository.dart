import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/storage_service.dart';
import '../models/team_bio_model.dart';

/// Repository for team players related API calls
class TeamPlayersRepository {
  /// Get all team players/members
  Future<List<TeamPlayerModel>> getTeamPlayers({required String teamId}) async {
    try {
      print('🔍 Fetching team players for teamId: $teamId');

      final userId = StorageService.userId;
      if (userId == null || userId.isEmpty) {
        throw Exception('User not logged in');
      }

      final response = await ApiClient.instance.post(
        ApiConstants.getTeamAllMembers,
        body: {
          'userId': userId,
          'teamId': teamId,
        },
      );

      print('🔍 Team Players API Response: $response');
      print('🔍 Response type: ${response.runtimeType}');
      print('🔍 Response keys: ${response.keys}');

      // Android uses structure: { status: 1, members: [...], memberCount: 16 }
      if (response['response']['status'] != 1) {
        print('❌ API returned status: ${response['response']['status']}');
        throw Exception('Failed to load team players');
      }

      if (response['response']['members'] == null) {
        print('ℹ️ No members field in response');
        return [];
      }

      final membersData = response['response']['members'] as List;
      print('✅ Found ${membersData.length} team members');

      if (membersData.isEmpty) {
        return [];
      }

      // Debug: Print first member structure
      print('📋 First member data: ${membersData.first}');

      final players = <TeamPlayerModel>[];
      for (var i = 0; i < membersData.length; i++) {
        try {
          final memberJson = membersData[i] as Map<String, dynamic>;

          // Only include members with jersey numbers (actual players)
          if (memberJson['teamJerseyNo'] != null) {
            final player = TeamPlayerModel.fromJson(memberJson);
            players.add(player);
          }
        } catch (e, stackTrace) {
          print('❌ Error parsing member at index $i: $e');
          print('Member data: ${membersData[i]}');
          print('Stack trace: $stackTrace');
        }
      }

      print('✅ Successfully parsed ${players.length} players');
      return players;
    } catch (e, stackTrace) {
      print('❌ Error in getTeamPlayers: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }
}
