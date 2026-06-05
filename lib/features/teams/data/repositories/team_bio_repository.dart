import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/storage_service.dart';
import '../models/team_bio_model.dart';
import '../models/team_match_model.dart';

class TeamBioLoadResult {
  TeamBioLoadResult({
    required this.teamBio,
    required this.actionInfo,
  });

  final TeamBioModel teamBio;
  final TeamBioActionInfo actionInfo;
}

class TeamBioActionInfo {
  const TeamBioActionInfo({
    this.isFollowing = false,
    this.followCount = 0,
    this.isAdmin = false,
    this.isPending = false,
    this.isMember = false,
    this.joinRequest = false,
    this.isArchive = false,
    this.createdBy,
    this.joinedOn,
  });

  final bool isFollowing;
  final int followCount;
  final bool isAdmin;
  final bool isPending;
  final bool isMember;
  final bool joinRequest;
  final bool isArchive;
  final String? createdBy;
  final int? joinedOn;
}

/// Thrown when the server rejects a delete request with a known reason code.
class TeamDeleteException implements Exception {
  final String message;
  const TeamDeleteException(this.message);
  @override
  String toString() => message;
}

/// Repository for team bio related API calls
class TeamBioRepository {
  /// Get team bio details
  Future<TeamBioLoadResult> getTeamBio({required String teamId}) async {
    try {
      print('🔍 Fetching team bio for teamId: $teamId');

      final userId = StorageService.userId;
      final response = await ApiClient.instance.post(
        ApiConstants.fetchTeamBio,
        body: {
          'teamId': teamId,
          if (userId != null && userId.isNotEmpty) 'userId': userId,
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
      final actionInfo = _parseActionInfo(teamBioData);

      // Fetch recent matches separately
      final recentMatches = await getTeamRecentMatches(teamId: teamId);

      // Return a new TeamBioModel with matches added using copyWith
      return TeamBioLoadResult(
        teamBio: teamBio.copyWith(recentMatches: recentMatches),
        actionInfo: actionInfo,
      );
    } catch (e, stackTrace) {
      print('❌ Error in getTeamBio: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  TeamBioActionInfo _parseActionInfo(Map<String, dynamic> teamBioData) {
    final teamDetails =
        teamBioData['teamDetails'] as Map<String, dynamic>? ?? {};
    final membership = teamBioData['membership'] as Map<String, dynamic>? ?? {};

    return TeamBioActionInfo(
      isFollowing: _readBool(teamDetails['following']) ||
          _readBool(teamDetails['isFollowing']) ||
          _readBool(teamDetails['followedByMe']),
      followCount: _readInt(teamDetails['followCount']),
      isAdmin: _readBool(membership['isAdmin']),
      isPending: _readBool(membership['isPending']),
      isMember: _readBool(membership['isMember']),
      joinRequest: _readBool(membership['joinRequest']),
      isArchive: _readBool(teamDetails['archive']) ||
          _readBool(teamDetails['isArchive']),
      createdBy: teamDetails['createdBy']?.toString(),
      joinedOn: _readNullableInt(membership['joinedOn']),
    );
  }

  /// Follow/unfollow team. Returns the new follow state from API.
  Future<bool> followTeam({required String teamId}) async {
    final currentUser = StorageService.currentUser;
    final userId = StorageService.userId;
    if (currentUser == null || userId == null || userId.isEmpty) {
      throw Exception('User not logged in');
    }

    final response = await ApiClient.instance.post(
      ApiConstants.followTeam,
      body: {
        'userId': userId,
        'teamId': teamId,
        'myName': _currentUserName(currentUser),
        'myImageUrl': currentUser['imageUrl']?.toString() ?? '',
        'country': currentUser['country']?.toString() ?? '',
        'gender': currentUser['gender']?.toString() ?? '',
        'birthYear': _birthYear(currentUser),
        'isPlayer': _readBool(currentUser['isPlayer']),
        'isCoach': _readBool(currentUser['isCoach']),
        'isAdmin': _readBool(currentUser['isAdmin']),
        'isFan': _readBool(currentUser['isFan']),
      },
    );

    final data = response['response'] as Map<String, dynamic>? ?? response;
    if (data['status'] == 1 && data['isFollow'] != null) {
      return _readBool(data['isFollow']);
    }
    throw Exception('Failed to update follow status');
  }

  /// Request to join a team. Returns true when request is accepted by API.
  Future<bool> requestTeamJoin({required String teamId}) async {
    final currentUser = StorageService.currentUser;
    final userId = StorageService.userId;
    if (currentUser == null || userId == null || userId.isEmpty) {
      throw Exception('User not logged in');
    }

    final response = await ApiClient.instance.post(
      ApiConstants.requestTeamJoin,
      body: {
        'playerId': userId,
        'teamId': teamId,
        'myName': _currentUserName(currentUser),
        'myImageUrl': currentUser['imageUrl']?.toString() ?? '',
        'isPlayer': _readBool(currentUser['isPlayer']),
        'isCoach': _readBool(currentUser['isCoach']),
        'isAdmin': _readBool(currentUser['isAdmin']),
        'isFan': _readBool(currentUser['isFan']),
      },
    );

    final data = response['response'] as Map<String, dynamic>? ?? response;
    return data['status'] == 1 && _readBool(data['success']);
  }

  String _currentUserName(Map<String, dynamic> currentUser) {
    final firstName = currentUser['firstName']?.toString() ?? '';
    final lastName = currentUser['lastName']?.toString() ?? '';
    final name = '$firstName $lastName'.trim();
    return name.isNotEmpty
        ? name
        : currentUser['profileName']?.toString() ?? '';
  }

  int _birthYear(Map<String, dynamic> currentUser) {
    final explicitYear = _readNullableInt(currentUser['yearOfBirth']);
    if (explicitYear != null && explicitYear > 0) return explicitYear;

    final dob = currentUser['dob']?.toString();
    if (dob == null || dob.isEmpty) return 0;
    final parts = dob.split('-');
    if (parts.length == 3) {
      return int.tryParse(parts.last) ?? int.tryParse(parts.first) ?? 0;
    }
    return 0;
  }

  bool _readBool(Object? value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) return value.toLowerCase() == 'true' || value == '1';
    return false;
  }

  int _readInt(Object? value) => _readNullableInt(value) ?? 0;

  int? _readNullableInt(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  /// Delete a team. Throws a [TeamDeleteException] with a user-facing message on
  /// business-logic failures, or a generic Exception on network/unexpected errors.
  Future<void> deleteTeam({required String teamId}) async {
    final userId = StorageService.userId;
    if (userId == null || userId.isEmpty) {
      throw Exception('User not logged in');
    }

    final response = await ApiClient.instance.post(
      ApiConstants.deleteTeam,
      body: {'teamId': teamId, 'userId': userId},
    );

    final data = response['response'] is Map
        ? Map<String, dynamic>.from(response['response'] as Map)
        : response;

    if (data['status'] == 1) {
      final success = _readBool(data['success']);
      if (success) return;

      final reason = data['reason']?.toString() ?? '';
      throw TeamDeleteException(_reasonMessage(reason));
    }
    throw Exception('Failed to delete team');
  }

  String _reasonMessage(String reason) {
    switch (reason) {
      case 'noTeam':
        return 'This team does not exist.';
      case 'noRight':
        return "You don't have permissions to delete.";
      case 'hasPlayer':
        return 'This team has players assigned and cannot be deleted. Please remove all players before you delete.';
      case 'hasMatch':
        return 'This team has participated in Matches, and cannot be deleted.';
      case 'hasTournament':
        return 'This team is participating in a Tournament, and cannot be deleted.';
      default:
        return 'Failed to delete team. Please try again.';
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

      const pageLimit = 50;
      final matches = <TeamMatchModel>[];
      final seenMatchIds = <String>{};

      for (var start = 0; start < 500; start += pageLimit) {
        final response = await ApiClient.instance.post(
          ApiConstants.getTeamRecentMatches,
          body: {
            'userId': userId,
            'teamId': teamId,
            'start': start,
            'limit': pageLimit,
          },
        );

        print('🔍 Recent Matches API Response: $response');

        // Android uses structure: { status: 1, matches: [...] }
        if (response['response']['status'] != 1) {
          print('❌ API returned status: ${response['response']['status']}');
          break;
        }

        if (response['response']['matches'] == null) {
          print('ℹ️ No matches field in response');
          break;
        }

        final matchesData = response['response']['matches'] as List;
        print('✅ Found ${matchesData.length} recent matches at start $start');

        if (matchesData.isEmpty) {
          break;
        }

        for (var i = 0; i < matchesData.length; i++) {
          try {
            final matchJson = matchesData[i] as Map<String, dynamic>;
            final match = TeamMatchModel.fromJson(matchJson);
            final key = match.matchId ?? match.id ?? '${start}_$i';
            if (seenMatchIds.add(key)) {
              matches.add(match);
            }
          } catch (e, stackTrace) {
            print('❌ Error parsing match at index $i: $e');
            print('Match data: ${matchesData[i]}');
            print('Stack trace: $stackTrace');
          }
        }

        if (matchesData.length < pageLimit) {
          break;
        }
      }

      matches.sort(
        (a, b) => (b.matchDateTimeGmt ?? 0).compareTo(a.matchDateTimeGmt ?? 0),
      );
      print('✅ Successfully parsed ${matches.length} matches');
      return matches;
    } catch (e, stackTrace) {
      print('❌ Error in getTeamRecentMatches: $e');
      print('Stack trace: $stackTrace');
      return []; // Return empty list on error, don't fail the whole bio
    }
  }
}
