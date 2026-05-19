import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/storage_service.dart';
import '../models/search_user_model.dart';

/// Repository for search related API calls
class SearchRepository {
  /// Advanced search for users
  Future<List<SearchUserModel>> advSearch({
    required String searchText,
    String country = '',
    String userType = '',
    String choice = '',
    int start = 0,
    int limit = 25,
  }) async {
    try {
      final userId = StorageService.userId;
      if (userId == null || userId.isEmpty) {
        throw Exception('User not logged in');
      }

      final response = await ApiClient.instance.post(
        ApiConstants.advSearch,
        body: {
          'userId': userId,
          'searchText': searchText,
          'country': country,
          'userType': userType.toLowerCase(),
          'choice': choice,
          'start': start,
          'limit': limit,
        },
      );

      final data = response['response'] as Map<String, dynamic>? ?? response;
      if (data['status'] == 1 && data['result'] != null) {
        final results = data['result'] as List;
        return results
            .map((json) =>
                SearchUserModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }
}
