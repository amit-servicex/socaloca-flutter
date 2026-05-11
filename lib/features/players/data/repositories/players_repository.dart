import 'dart:developer';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/player_model.dart';

/// Repository for players-related API calls
class PlayersRepository {
  /// Get players list with filters
  Future<List<PlayerModel>> getPlayers({
    required String userId,
    required String country,
    String playPosition = '',
    String gender = '',
    String ageGroup = '',
    int start = 0,
    int limit = 10,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getFanPlayers,
        body: {
          'userId': userId,
          'country': country,
          'playPosition': playPosition,
          'gender': gender.toLowerCase(),
          'ageGroup': ageGroup,
          'dateToday': _getPlainDate(),
          'start': start,
          'limit': limit,
        },
      );
      log("players response: successfully parsed out of if ${response['response']['status']}");

      if (response['response']['status'] == 1 &&
          response['response']['players'] != null) {
        log("players response: successfully parsed ${response['response']['status']}");
        final players = response['response']['players'] as List;
        return players
            .map((p) => PlayerModel.fromJson(p as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  /// Get current date in plain format (dd-MM-yyyy)
  String _getPlainDate() {
    final now = DateTime.now();
    return '${now.day}-${now.month}-${now.year}';
  }
}
