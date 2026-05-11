import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/pickup_match_model.dart';

/// Repository for Pickup Matches
class PickupMatchRepository {
  /// Get pickup matches list
  Future<List<PickupMatchModel>> getPickupMatches({
    required String userId,
    required String country,
    int start = 0,
    int limit = 10,
  }) async {
    try {
      print('📡 [Pickup API] Calling getPickupMatches');

      final response = await ApiClient.instance.post(
        ApiConstants.getPickUpMatches,
        body: {
          'userId': userId,
          'country': country,
          'start': start,
          'limit': limit,
        },
      );

      print('📡 [Pickup API] Response keys: ${response.keys.toList()}');

      // Response is nested: {"response": {"status": 1, "matches": [...]}}
      final data = response['response'] as Map<String, dynamic>?;
      if (data != null && data['status'] == 1 && data['matches'] != null) {
        final matches = data['matches'] as List;
        print('📡 [Pickup API] Found ${matches.length} pickup matches');

        final parsed = matches
            .map((m) => PickupMatchModel.fromJson(m as Map<String, dynamic>))
            .toList();

        // Sort by start time (ascending)
        parsed.sort((a, b) => a.startTimeGmt.compareTo(b.startTimeGmt));

        print('✅ [Pickup API] Parsed ${parsed.length} pickup matches');
        return parsed;
      }
      print('⚠️ [Pickup API] No pickup matches found');
      return [];
    } catch (e, stack) {
      print('❌ [Pickup API] Error fetching pickup matches: $e');
      print('Stack: $stack');
      return [];
    }
  }

  /// Get pickup match details
  Future<PickupMatchModel?> getPickupMatchDetails({
    required String userId,
    required String matchId,
  }) async {
    try {
      print('📡 [Pickup API] Calling pickUpMatchDetails for $matchId');

      final response = await ApiClient.instance.post(
        ApiConstants.pickUpMatchDetails,
        body: {
          'userId': userId,
          'matchId': matchId,
        },
      );

      final data = response['response'] as Map<String, dynamic>?;
      if (data != null) {
        final match = PickupMatchModel.fromJson(data);
        print('✅ [Pickup API] Match details loaded');
        return match;
      }
      return null;
    } catch (e, stack) {
      print('❌ [Pickup API] Error fetching match details: $e');
      print('Stack: $stack');
      return null;
    }
  }

  /// Host a new pickup match
  Future<bool> hostPickupMatch({
    required String userId,
    required Map<String, dynamic> matchData,
  }) async {
    try {
      print('📡 [Pickup API] Calling hostPickupMatch');

      final response = await ApiClient.instance.post(
        ApiConstants.hostPickupMatch,
        body: {
          'userId': userId,
          ...matchData,
        },
      );

      final data = response['response'] as Map<String, dynamic>?;
      if (data != null && data['status'] == 1) {
        print('✅ [Pickup API] Match hosted successfully');
        return true;
      }
      return false;
    } catch (e, stack) {
      print('❌ [Pickup API] Error hosting match: $e');
      print('Stack: $stack');
      return false;
    }
  }

  /// Request to join a pickup match
  Future<bool> requestPickupMatch({
    required String userId,
    required String matchId,
  }) async {
    try {
      print('📡 [Pickup API] Calling reqPickupMatch');

      final response = await ApiClient.instance.post(
        ApiConstants.reqPickupMatch,
        body: {
          'userId': userId,
          'matchId': matchId,
        },
      );

      final data = response['response'] as Map<String, dynamic>?;
      if (data != null && data['status'] == 1) {
        print('✅ [Pickup API] Request sent successfully');
        return true;
      }
      return false;
    } catch (e, stack) {
      print('❌ [Pickup API] Error requesting match: $e');
      print('Stack: $stack');
      return false;
    }
  }

  /// Accept or decline a pickup match request
  Future<bool> acceptDeclineRequest({
    required String userId,
    required String matchId,
    required String requestedUserId,
    required String status, // 'accepted' or 'declined'
  }) async {
    try {
      print('📡 [Pickup API] Calling acceptDeclinePickupRequest');

      final response = await ApiClient.instance.post(
        ApiConstants.acceptDeclinePickupRequest,
        body: {
          'userId': userId,
          'matchId': matchId,
          'requestedUserId': requestedUserId,
          'status': status,
        },
      );

      final data = response['response'] as Map<String, dynamic>?;
      if (data != null && data['status'] == 1) {
        print('✅ [Pickup API] Request $status successfully');
        return true;
      }
      return false;
    } catch (e, stack) {
      print('❌ [Pickup API] Error accepting/declining request: $e');
      print('Stack: $stack');
      return false;
    }
  }
}

/// Provider for PickupMatchRepository
final pickupMatchRepositoryProvider = Provider<PickupMatchRepository>((ref) {
  return PickupMatchRepository();
});
