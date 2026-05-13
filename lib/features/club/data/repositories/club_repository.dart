import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socaloca/features/club/data/models/club_player_model.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/club_bio_model.dart';
import '../models/club_model.dart';

final clubRepositoryProvider = Provider((ref) => ClubRepository());

/// Club repository for all club-related API calls
class ClubRepository {
  /// Get clubs list with filters
  /// Matches getClubs API from Android
  Future<List<ClubModel>> getClubs({
    required String userId,
    String country = '',
    String confed = '',
    String partnerShip = '',
    String trial = '',
    int start = 0,
    int limit = 10,
  }) async {
    try {
      print('📡 Calling getClubs API...');
      final response = await ApiClient.instance.post(
        ApiConstants.getClubs,
        body: {
          'userId': userId,
          'country': country,
          'confed': confed,
          'partnerShip': partnerShip,
          'trial': trial,
          'start': start,
          'limit': limit,
        },
      );

      print('📦 API Response keys: ${response.keys.toList()}');
      print('📦 Full API Response: $response');

      // The API returns nested response: { response: { clubs } }
      final responseData = response['response'] as Map<String, dynamic>?;

      if (responseData == null) {
        print('🔴 No response data found');
        print('🔴 Response structure: $response');
        return [];
      }

      print('📦 Response data keys: ${responseData.keys.toList()}');
      print('📦 Response data type: ${responseData.runtimeType}');

      if (responseData['clubs'] != null) {
        final clubsData = responseData['clubs'];
        print('📦 Clubs data type: ${clubsData.runtimeType}');

        if (clubsData is! List) {
          print('🔴 Clubs is not a List, it is: ${clubsData.runtimeType}');
          print('🔴 Clubs data: $clubsData');
          return [];
        }

        final clubsJson = clubsData as List;
        print('✅ Found ${clubsJson.length} clubs in response');
        print('✅ Parsing clubs...');

        final clubs = <ClubModel>[];
        for (var i = 0; i < clubsJson.length; i++) {
          try {
            final clubData = clubsJson[i];
            print(
                '📦 Processing club $i: ${clubData is Map ? (clubData as Map)['clubName'] : 'invalid'}');

            if (clubData is Map<String, dynamic>) {
              final club = ClubModel.fromApiJson(clubData);
              clubs.add(club);
              print('✅ Added club: ${club.clubName}');
            } else {
              print(
                  '⚠️ Club at index $i is not a Map: ${clubData.runtimeType}');
            }
          } catch (e, stackTrace) {
            print('❌ Error parsing club at index $i: $e');
            print('Stack trace: $stackTrace');
            if (i < clubsJson.length) {
              print('Club JSON keys: ${(clubsJson[i] as Map?)?.keys.toList()}');
            }
            // Continue parsing other clubs instead of failing completely
          }
        }

        print(
            '✅ Successfully parsed ${clubs.length} out of ${clubsJson.length} clubs');
        return clubs;
      }

      print('⚠️ No clubs in response');
      return [];
    } catch (e, stackTrace) {
      print('❌ Error in getClubs: $e');
      print('Stack trace: $stackTrace');
      return [];
    }
  }

  /// Get club bio/details
  /// Matches getClubBio API from Android
  Future<ClubBioModel?> getClubBio({
    required String clubId,
    required String userId,
  }) async {
    try {
      print('📡 Calling getClubBio API for clubId: $clubId');
      final response = await ApiClient.instance.post(
        ApiConstants.getClubBio,
        body: {
          'clubId': clubId,
          'userId': userId,
          'isUser': true,
        },
      );

      print('📦 API Response keys: ${response.keys.toList()}');

      // The API returns nested response: { response: { status, details } }
      final responseData = response['response'] as Map<String, dynamic>?;

      if (responseData == null) {
        print('🔴 No response data found');
        return null;
      }

      print('📦 Response data keys: ${responseData.keys.toList()}');

      if (responseData['status'] == 1 && responseData['details'] != null) {
        final detailsJson = responseData['details'] as Map<String, dynamic>;
        print('✅ Parsing club bio details...');

        try {
          final clubBio = ClubBioModel.fromApiJson(detailsJson);
          print('✅ Successfully parsed club bio');
          return clubBio;
        } catch (e) {
          print('❌ Error parsing club bio: $e');
          print('Details JSON: $detailsJson');
          return null;
        }
      }

      print('⚠️ No details in response or status != 1');
      return null;
    } catch (e, stackTrace) {
      print('❌ Error in getClubBio: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

  /// Follow/unfollow a club
  /// Matches followClub API from Android
  Future<bool> followClub({
    required String clubId,
    required String userId,
  }) async {
    try {
      print('📡 Calling followClub API for clubId: $clubId');
      final response = await ApiClient.instance.post(
        ApiConstants.followClub,
        body: {
          'clubId': clubId,
          'userId': userId,
        },
      );

      print('📦 Follow club response: $response');

      // Check for success
      final status = response['status'];
      final success = status == 1 || status == '1';

      print(success ? '✅ Follow club successful' : '⚠️ Follow club failed');
      return success;
    } catch (e, stackTrace) {
      print('❌ Error in followClub: $e');
      print('Stack trace: $stackTrace');
      return false;
    }
  }

  /// Upgrade club plan (admin only)
  Future<bool> upgradeClubPlan({required String clubId}) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.upgradeClubPlan,
        body: {'clubId': clubId},
      );
      final data = response['response'] as Map<String, dynamic>? ?? response;
      return (data['status'] == 1 || data['success'] == true);
    } catch (_) {
      return false;
    }
  }

  // ─── Club Admin methods ──────────────────────────────────────────────────

  /// getClubBio — admin view (isUser: false).
  Future<ClubBioModel?> getClubBioAdmin({required String clubId}) async {
    log("the club api is call and the detils should be show in the console");
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getClubBio,
        body: {'clubId': clubId, 'userId': null, 'isUser': false},
      );
      final data = response['response'] as Map<String, dynamic>? ?? response;
      if ((data['status'] == 1) && data['details'] != null) {
        return ClubBioModel.fromApiJson(
            data['details'] as Map<String, dynamic>);
      }
      print(
          '❌ getClubBioAdmin: status=${data['status']}, message=${data['message']}');
      return null;
    } catch (e, st) {
      print('❌ getClubBioAdmin error: $e\n$st');
      return null;
    }
  }

  /// getClubPlayerList — paginated list of club players (admin view).
  Future<List<ClubPlayerModel>> getClubPlayerList({
    required String clubId,
    int start = 0,
    int limit = 10,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getClubPlayerList,
        body: {
          'userId': clubId,
          'clubId': clubId,
          'start': start,
          'limit': limit,
        },
      );
      final data = response['response'] as Map<String, dynamic>? ?? response;
      final raw = data['players'] as List? ?? [];
      return raw
          .map((e) => ClubPlayerModel.fromApiJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  /// getClubPlayerDetails — full detail for a single club player.
  Future<ClubPlayerModel?> getClubPlayerDetails({
    required String playerId,
    required String clubId,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getClubPlayerDetails,
        body: {'playerId': playerId, 'clubId': clubId},
      );
      final data = response['response'] as Map<String, dynamic>? ?? response;
      if (data['playerDetails'] != null) {
        return ClubPlayerModel.fromApiJson(
            data['playerDetails'] as Map<String, dynamic>);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// getPlayerStats — football + futsal stats for a player.
  Future<Map<String, dynamic>> getPlayerStats({
    required String playerId,
    required int year,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getPlayerStats,
        body: {'playerId': playerId, 'year': year},
      );
      final data = response['response'] as Map<String, dynamic>? ?? response;
      return data;
    } catch (_) {
      return {};
    }
  }

  /// getClubPostList — paginated club gallery posts.
  Future<List<Map<String, dynamic>>> getClubPostList({
    required String clubId,
    int start = 0,
    int limit = 5,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getClubPostList,
        body: {
          'userId': clubId,
          'clubId': clubId,
          'start': start,
          'limit': limit,
        },
      );
      final data = response['response'] as Map<String, dynamic>? ?? response;
      final raw = data['posts'] as List? ?? [];
      return raw.cast<Map<String, dynamic>>();
    } catch (_) {
      return [];
    }
  }

  /// allClubTrials — paginated platform-wide trials with filters.
  Future<List<Map<String, dynamic>>> allClubTrials({
    String countryName = '',
    String fromAge = '',
    String toAge = '',
    int start = 0,
    int limit = 10,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.allClubTrials,
        body: {
          'countryName': countryName,
          'fromAge': fromAge,
          'toAge': toAge,
          'start': start,
          'limit': limit,
        },
      );
      final data = response['response'] as Map<String, dynamic>? ?? response;
      final raw = data['trials'] as List? ?? [];
      return raw.cast<Map<String, dynamic>>();
    } catch (_) {
      return [];
    }
  }

  /// trialRegister by trialId + email (platform-wide trial registration).
  Future<bool> trialRegisterByTrialId({
    required String trialId,
    required String email,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.trialRegister,
        body: {'trialId': trialId, 'email': email},
      );
      final data = response['response'] as Map<String, dynamic>? ?? response;
      return (data['status'] == 1 || data['success'] == true);
    } catch (_) {
      return false;
    }
  }
}
