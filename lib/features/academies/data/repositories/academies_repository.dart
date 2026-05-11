import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/academy_model.dart';

/// Repository for academies related API calls
class AcademiesRepository {
  /// Get academy list with filters
  Future<List<AcademyModel>> getAcademyList({
    required String userId,
    String? country,
    String? confed,
    String? category,
    int start = 0,
    int limit = 10,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getAcademyList,
        body: {
          'userId': userId,
          'country': country ?? '',
          'confed': confed ?? '',
          'category': category ?? '',
          'start': start,
          'limit': limit,
        },
      );

      if (response['response']['status'] == 1 &&
          response['response']['academys'] != null) {
        final academys = response['response']['academys'] as List;
        final academyList = academys
            .map((academy) =>
                AcademyModel.fromJson(academy as Map<String, dynamic>))
            .toList();

        // Sort alphabetically by name
        academyList.sort((a, b) {
          final nameA = a.name ?? '';
          final nameB = b.name ?? '';
          return nameA.compareTo(nameB);
        });

        return academyList;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
