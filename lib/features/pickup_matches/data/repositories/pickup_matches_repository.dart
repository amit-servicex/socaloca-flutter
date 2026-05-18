import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../pickup_match_data.dart';

class PickupMatchesRepository {
  /// Fetch paginated list of pickup matches for the user's country.
  Future<List<PickupMatchData>> getPickupMatches({
    required String userId,
    required String country,
    int start = 0,
    int limit = 10,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getPickUpMatches,
        body: {
          'userId': userId,
          'country': country,
          'start': start,
          'limit': limit,
        },
      );

      final data = response['response'] as Map<String, dynamic>?;
      if (data != null && data['status'] == 1) {
        final matches = data['matches'] as List? ?? data['data'] as List? ?? [];
        return matches
            .map((m) => PickupMatchData.fromJson(m as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      print('❌ [Pickup API] getPickupMatches error: $e');
      return [];
    }
  }

  /// Send a join request for a pickup match.
  Future<bool> requestToJoin({
    required String matchId,
    required String userId,
    required String createdBy,
    required String myName,
    required String myImageUrl,
    bool isPlayer = false,
    bool isCoach = false,
    bool isAdmin = false,
    bool isFan = false,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.reqPickupMatch,
        body: {
          'matchId': matchId,
          'userId': userId,
          'createdBy': createdBy,
          'myName': myName,
          'myImageUrl': myImageUrl,
          'isPlayer': isPlayer,
          'isCoach': isCoach,
          'isAdmin': isAdmin,
          'isFan': isFan,
        },
      );
      final data = response['response'] as Map<String, dynamic>?;
      return data != null && data['status'] == 1;
    } catch (e) {
      print('❌ [Pickup API] requestToJoin error: $e');
      return false;
    }
  }

  /// Host a new pickup match.
  Future<bool> hostPickupMatch({
    required String userId,
    required String ageGroup,
    required String gender,
    required String matchDate,
    required String startTime,
    required int startTimeGmt,
    required String endTime,
    required int endTimeGmt,
    required String venue,
    required String country,
    required String locationName,
    required double locationLat,
    required double locationLng,
    required int maxPlayers,
    String? matchNote,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.hostPickupMatch,
        body: {
          'userId': userId,
          'ageGroup': ageGroup,
          'gender': gender,
          'matchDate': matchDate,
          'startTime': startTime,
          'startTimeGmt': startTimeGmt,
          'endTime': endTime,
          'endTimeGmt': endTimeGmt,
          'venue': venue,
          'country': country,
          'locationName': locationName,
          'locationLat': locationLat,
          'locationLng': locationLng,
          'maxPlayers': maxPlayers,
          if (matchNote != null && matchNote.isNotEmpty) 'matchNote': matchNote,
        },
      );
      final data = response['response'] as Map<String, dynamic>?;
      return data != null && data['status'] == 1;
    } catch (e) {
      print('❌ [Pickup API] hostPickupMatch error: $e');
      return false;
    }
  }
}

final pickupMatchesRepositoryProvider =
    Provider<PickupMatchesRepository>((ref) => PickupMatchesRepository());
