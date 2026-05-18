import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/storage/storage_service.dart';

class SettingsRepository {
  String get _userId => StorageService.userId ?? '';

  Future<Map<String, dynamic>?> getLegacyContact() async {
    final response = await ApiClient.instance.post(
      ApiConstants.getLegacyContact,
      body: {'userId': _userId},
    );
    final inner = _inner(response);
    if (inner['status'] != 1) return null;
    return {
      'hasContact': inner['hasContact'] == true,
      'contactName': inner['details']?['contactName']?.toString() ?? '',
      'contactEmail': inner['details']?['contactEmail']?.toString() ?? '',
    };
  }

  Future<bool> saveLegacyContact({
    required String contactName,
    required String contactEmail,
  }) async {
    final user = StorageService.currentUser;
    final firstName = user?['firstName']?.toString() ?? '';
    final lastName = user?['lastName']?.toString() ?? '';
    final myName = '$firstName $lastName'.trim();

    final response = await ApiClient.instance.post(
      ApiConstants.saveLegacyContact,
      body: {
        'userId': _userId,
        'myName': myName,
        'contactName': contactName,
        'contactEmail': contactEmail,
      },
    );
    final inner = _inner(response);
    return inner['status'] == 1 && inner['success'] == true;
  }

  Map<String, dynamic> _inner(Map<String, dynamic> raw) {
    if (raw.containsKey('response') && raw['response'] is Map) {
      return raw['response'] as Map<String, dynamic>;
    }
    return raw;
  }
}
