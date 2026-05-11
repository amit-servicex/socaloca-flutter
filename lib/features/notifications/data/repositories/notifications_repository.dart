import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/storage_service.dart';
import '../models/notification_model.dart';

/// Repository for notifications related API calls
class NotificationsRepository {
  /// Get notifications list with pagination
  Future<List<NotificationModel>> getNotifications({
    required int skip,
    required int limit,
  }) async {
    try {
      final userId = StorageService.userId;
      if (userId == null || userId.isEmpty) {
        throw Exception('User not logged in');
      }

      final response = await ApiClient.instance.post(
        ApiConstants.getNotifications,
        body: {
          'userId': userId,
          'start': skip, // Android uses 'start' not 'skip'
          'limit': limit,
        },
      );

      // Android response structure: { status: 1, notifications: [...] }
      // Not nested under 'response' key
      if (response['response']['status'] == 1 &&
          response['response']['notifications'] != null) {
        final notificationsData = response['response']['notifications'] as List;
        return notificationsData
            .map((json) =>
                NotificationModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }
}
