import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/storage_service.dart';
import '../models/confed_bio_model.dart';
import '../models/fa_bio_model.dart';
import '../models/partner_models.dart';
import '../models/sponsor_charity_bio_models.dart';

final partnersRepositoryProvider = Provider((_) => PartnersRepository());

class PartnersRepository {
  static const int _pageSize = 10;

  // ─── FA ──────────────────────────────────────────────────────────────────

  Future<List<FaModel>> getFAs({
    String confed = '',
    int start = 0,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getFAList,
        body: {
          'userId': StorageService.userId ?? '',
          'confed': confed,
          'start': start,
          'limit': _pageSize,
        },
      );
      final data = response['response'] as Map<String, dynamic>?;
      final list = data?['fas'];
      if (list == null || list is! List) return [];
      return list
          .whereType<Map<String, dynamic>>()
          .map(FaModel.fromJson)
          .toList();
    } catch (_) {
      return [];
    }
  }

  // ─── Confederation ────────────────────────────────────────────────────────

  Future<List<ConfedModel>> getConfeds({int start = 0}) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getConfedList,
        body: {
          'userId': StorageService.userId ?? '',
          'start': start,
          'limit': _pageSize,
        },
      );
      final data = response['response'] as Map<String, dynamic>?;
      final list = data?['confeds'];
      if (list == null || list is! List) return [];
      return list
          .whereType<Map<String, dynamic>>()
          .map(ConfedModel.fromJson)
          .toList();
    } catch (_) {
      return [];
    }
  }

  // ─── Sponsor ──────────────────────────────────────────────────────────────

  Future<List<SponsorModel>> getSponsors({
    String country = '',
    String partnerShip = '',
    int start = 0,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getSponList,
        body: {
          'userId': StorageService.userId ?? '',
          'country': country,
          'confed': '',
          'partnerShip': partnerShip,
          'start': start,
          'limit': _pageSize,
        },
      );
      final data = response['response'] as Map<String, dynamic>?;
      final list = data?['sponsors'];
      if (list == null || list is! List) return [];
      final sponsors = list
          .whereType<Map<String, dynamic>>()
          .map(SponsorModel.fromJson)
          .toList();
      // Sort by plan desc, then name asc (matches Android comparator)
      sponsors.sort((a, b) {
        final planCmp = b.plan.compareTo(a.plan);
        if (planCmp != 0) return planCmp;
        return (a.sponsorName).compareTo(b.sponsorName);
      });
      return sponsors;
    } catch (_) {
      return [];
    }
  }

  // ─── FA Bio ───────────────────────────────────────────────────────────────

  Future<FaBioModel?> getFaBio({required String faId}) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getFABio,
        body: {
          'userId': StorageService.userId ?? '',
          'faId': faId,
        },
      );
      final responseData = response['response'] as Map<String, dynamic>?;
      if (responseData == null) return null;
      final status = responseData['status'];
      if ((status == 1 || status == '1') && responseData['details'] != null) {
        return FaBioModel.fromApiJson(
          responseData['details'] as Map<String, dynamic>,
        );
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  // ─── Confed Bio ──────────────────────────────────────────────────────────

  Future<ConfedBioModel?> getConfedBio({required String confedId}) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getConfedBio,
        body: {
          'userId': StorageService.userId ?? '',
          'confedId': confedId,
        },
      );
      final responseData = response['response'] as Map<String, dynamic>?;
      if (responseData == null) return null;
      final status = responseData['status'];
      if ((status == 1 || status == '1') && responseData['details'] != null) {
        return ConfedBioModel.fromApiJson(
          responseData['details'] as Map<String, dynamic>,
        );
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<void> followConfed({required String confedId}) async {
    try {
      final user = StorageService.currentUser ?? {};
      final firstName = user['firstName']?.toString() ?? '';
      final lastName = user['lastName']?.toString() ?? '';
      final myName = '$firstName $lastName'.trim();
      final birthYear = _birthYearFromUser(user);
      await ApiClient.instance.post(
        ApiConstants.followConfed,
        body: {
          'userId': StorageService.userId ?? '',
          'confedId': confedId,
          'myName': myName,
          'myImageUrl': user['imageUrl']?.toString() ?? '',
          'country': user['country']?.toString() ?? '',
          'gender': user['gender']?.toString() ?? '',
          'birthYear': birthYear,
          'isPlayer': user['isPlayer'] ?? false,
          'isCoach': user['isCoach'] ?? false,
          'isAdmin': user['isAdmin'] ?? false,
          'isFan': user['isFan'] ?? false,
        },
      );
    } catch (_) {
      // fire-and-forget; caller uses optimistic toggle
    }
  }

  int _birthYearFromUser(Map<String, dynamic> user) {
    final yearOfBirth = int.tryParse(user['yearOfBirth']?.toString() ?? '');
    if (yearOfBirth != null && yearOfBirth > 0) return yearOfBirth;
    final dob = user['dob']?.toString() ?? '';
    if (dob.length == 10) {
      // dob may be "yyyy-MM-dd" or "dd-MM-yyyy"
      final parts = dob.split('-');
      if (parts.length == 3) {
        final year = int.tryParse(parts[2]) ?? int.tryParse(parts[0]) ?? 0;
        if (year > 1900) return year;
      }
    }
    return 0;
  }

  // ─── Sponsor Bio ─────────────────────────────────────────────────────────

  Future<SponsorBioModel?> getSponsorBio({required String sponsorId}) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getSponBio,
        body: {
          'userId': StorageService.userId ?? '',
          'sponsorId': sponsorId,
        },
      );
      final responseData = response['response'] as Map<String, dynamic>?;
      if (responseData == null) return null;
      final status = responseData['status'];
      if ((status == 1 || status == '1') && responseData['details'] != null) {
        return SponsorBioModel.fromApiJson(
          responseData['details'] as Map<String, dynamic>,
        );
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  // ─── Charity Bio ──────────────────────────────────────────────────────────

  Future<CharityBioModel?> getCharityBio({required String charityId}) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getCharityBio,
        body: {
          'userId': StorageService.userId ?? '',
          'charityId': charityId,
        },
      );
      final responseData = response['response'] as Map<String, dynamic>?;
      if (responseData == null) return null;
      final status = responseData['status'];
      if ((status == 1 || status == '1') && responseData['details'] != null) {
        return CharityBioModel.fromApiJson(
          responseData['details'] as Map<String, dynamic>,
        );
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  // ─── Charity / NGO ───────────────────────────────────────────────────────

  Future<List<CharityModel>> getCharities({
    String country = '',
    String partnerShip = '',
    int start = 0,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getCharityList,
        body: {
          'userId': StorageService.userId ?? '',
          'country': country,
          'confed': '',
          'partnerShip': partnerShip,
          'start': start,
          'limit': _pageSize,
        },
      );
      final data = response['response'] as Map<String, dynamic>?;
      final list = data?['charities'];
      if (list == null || list is! List) return [];
      final charities = list
          .whereType<Map<String, dynamic>>()
          .map(CharityModel.fromJson)
          .toList();
      charities.sort((a, b) {
        final planCmp = b.plan.compareTo(a.plan);
        if (planCmp != 0) return planCmp;
        return (a.charityName).compareTo(b.charityName);
      });
      return charities;
    } catch (_) {
      return [];
    }
  }
}
