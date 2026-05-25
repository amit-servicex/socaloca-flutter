import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/storage_service.dart';
import '../models/team_model.dart';

/// Repository for teams related API calls
class TeamsRepository {
  /// Get teams with filters
  Future<List<TeamModel>> getTeams({
    String location = '',
    String gameType = '',
    String gender = '',
    String ageRange = '',
    String ageCategory = '',
    int start = 0,
    int limit = 10,
  }) async {
    try {
      final userId = StorageService.userId;
      final user = StorageService.currentUser;
      final userCountry = user?['country'] ?? '';

      if (userId == null || userId.isEmpty) {
        throw Exception('User not logged in');
      }

      final response = await ApiClient.instance.post(
        ApiConstants.getTeams,
        body: {
          'userId': userId,
          'country': userCountry,
          'city': location,
          'gender': gender.toLowerCase(),
          'ageGroup': ageRange,
          'ageCat': ageCategory,
          'gameType': gameType,
          'start': start,
          'limit': limit,
        },
      );

      // Debug: Print the response structure
      print('🔍 Teams API Response: $response');
      print('🔍 Response type: ${response.runtimeType}');
      print('🔍 Response keys: ${response.keys}');

      // Android uses direct structure: { status: 1, teams: [...] }
      if (response['response']['status'] != 1) {
        print('❌ API returned status: ${response['response']['status']}');
        return [];
      }

      if (response['response']['teams'] == null) {
        print('❌ No teams field in response');
        return [];
      }

      final teamsData = response['response']['teams'] as List;
      print('✅ Found ${teamsData.length} teams');

      if (teamsData.isEmpty) {
        return [];
      }

      // Debug: Print first team structure
      print('📋 First team data: ${teamsData.first}');

      final teams = <TeamModel>[];
      for (var i = 0; i < teamsData.length; i++) {
        try {
          final teamJson = Map<String, dynamic>.from(
            teamsData[i] as Map<String, dynamic>,
          );
          // Ensure required non-nullable fields have fallback values
          teamJson['teamId'] =
              teamJson['teamId'] ?? teamJson['_id'] ?? '';
          teamJson['teamName'] =
              teamJson['teamName'] ?? teamJson['name'] ?? '';
          final team = TeamModel.fromJson(teamJson);
          teams.add(team);
        } catch (e, stackTrace) {
          print('❌ Error parsing team at index $i: $e');
          print('Team data: ${teamsData[i]}');
          print('Stack trace: $stackTrace');
        }
      }

      print('✅ Successfully parsed ${teams.length} teams');
      return teams;
    } catch (e, stackTrace) {
      print('❌ Error in getTeams: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }
}
