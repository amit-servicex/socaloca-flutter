import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/academy_bio_models.dart';
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

      final respData = response['response'] is Map
          ? Map<String, dynamic>.from(response['response'] as Map)
          : response;
      if (respData['status'] == 1 && respData['academys'] != null) {
        final rawAcademys = respData['academys'];
        if (rawAcademys is! List) return [];
        final academyList = rawAcademys
            .whereType<Map>()
            .map((academy) =>
                AcademyModel.fromJson(Map<String, dynamic>.from(academy)))
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

  Future<AcademyBioData?> getAcademyBio({
    required String userId,
    required String academyId,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getAcademyBio,
        body: {'userId': userId, 'academyId': academyId},
      );

      final data = response['response'] is Map
          ? Map<String, dynamic>.from(response['response'] as Map)
          : response;
      if (data['status'] != 1 || data['details'] == null) return null;

      final rawDetails = data['details'];
      if (rawDetails is! Map) return null;
      final details = Map<String, dynamic>.from(rawDetails);

      String? joinedStatus;
      if (details['joinDetails'] is Map) {
        final jd = Map<String, dynamic>.from(details['joinDetails'] as Map);
        joinedStatus = jd['joined'] as String?;
      }

      AcademyDetailModel? academyDetails;
      if (details['academyDetails'] is Map) {
        academyDetails = AcademyDetailModel.fromJson(
            Map<String, dynamic>.from(details['academyDetails'] as Map));
      }

      final banners = <AcademyBannerModel>[];
      if (details['banners'] is List) {
        for (final b in details['banners'] as List) {
          if (b is! Map) continue;
          final bm = AcademyBannerModel.fromJson(Map<String, dynamic>.from(b));
          if (bm.imageUrl.isNotEmpty) banners.add(bm);
        }
      }

      AcademyTrialStatusModel? trialDetails;
      if (details['trialDetails'] is Map) {
        trialDetails = AcademyTrialStatusModel.fromJson(
            Map<String, dynamic>.from(details['trialDetails'] as Map));
      }

      final newsList = <AcademyNewsModel>[];
      if (details['newsList'] is List) {
        for (final n in details['newsList'] as List) {
          if (n is! Map) continue;
          newsList.add(AcademyNewsModel.fromJson(Map<String, dynamic>.from(n)));
        }
      }

      final postList = <AcademyPostModel>[];
      if (details['postList'] is List) {
        for (final p in details['postList'] as List) {
          if (p is! Map) continue;
          postList.add(AcademyPostModel.fromJson(Map<String, dynamic>.from(p)));
        }
      }

      final sponsorList = <AcademySponsorModel>[];
      if (details['sponsorList'] is List) {
        for (final s in details['sponsorList'] as List) {
          if (s is! Map) continue;
          sponsorList
              .add(AcademySponsorModel.fromJson(Map<String, dynamic>.from(s)));
        }
      }

      final teams = <AcademyTeamModel>[];
      if (details['teams'] is List) {
        for (final t in details['teams'] as List) {
          if (t is! Map) continue;
          teams.add(AcademyTeamModel.fromJson(Map<String, dynamic>.from(t)));
        }
      }

      final skillVdos = <AcademyPostModel>[];
      if (details['skillVdos'] is List) {
        for (final v in details['skillVdos'] as List) {
          if (v is! Map) continue;
          skillVdos
              .add(AcademyPostModel.fromJson(Map<String, dynamic>.from(v)));
        }
        skillVdos.sort((a, b) => b.addedOn.compareTo(a.addedOn));
      }

      final matchVdos = <AcademyPostModel>[];
      if (details['matchVdos'] is List) {
        for (final v in details['matchVdos'] as List) {
          if (v is! Map) continue;
          matchVdos
              .add(AcademyPostModel.fromJson(Map<String, dynamic>.from(v)));
        }
        matchVdos.sort((a, b) => b.addedOn.compareTo(a.addedOn));
      }

      return AcademyBioData(
        joinedStatus: joinedStatus,
        academyDetails: academyDetails,
        banners: banners,
        trialDetails: trialDetails,
        newsList: newsList,
        postList: postList,
        sponsorList: sponsorList,
        teams: teams,
        skillVdos: skillVdos,
        matchVdos: matchVdos,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> followAcademy({
    required String userId,
    required String academyId,
    required String myName,
    required String myImageUrl,
    required String country,
    required String gender,
    required int birthYear,
    required bool isPlayer,
    required bool isCoach,
    required bool isAdmin,
    required bool isFan,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.followAcademy,
        body: {
          'userId': userId,
          'academyId': academyId,
          'myName': myName,
          'myImageUrl': myImageUrl,
          'country': country,
          'gender': gender,
          'birthYear': birthYear,
          'isPlayer': isPlayer,
          'isCoach': isCoach,
          'isAdmin': isAdmin,
          'isFan': isFan,
        },
      );
      final data = response['response'] is Map
          ? Map<String, dynamic>.from(response['response'] as Map)
          : response;
      return data['status'] == 1;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>?> joinAcademy({
    required String userId,
    required String academyId,
    required bool request,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.joinAcademy,
        body: {
          'userId': userId,
          'academyId': academyId,
          'request': request,
        },
      );
      final data = response['response'] is Map
          ? Map<String, dynamic>.from(response['response'] as Map)
          : response;
      if (data['status'] == 1 && data['success'] == true) {
        return {'joined': data['joined']};
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<AcademyPostModel>> getAcademyPostList({
    required String userId,
    required String academyId,
    int start = 0,
    int limit = 10,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getAcademyPostList,
        body: {
          'userId': userId,
          'academyId': academyId,
          'start': start,
          'limit': limit,
        },
      );
      final data = response['response'] is Map
          ? Map<String, dynamic>.from(response['response'] as Map)
          : response;
      if (data['status'] != 1 || data['posts'] is! List) return [];
      return (data['posts'] as List)
          .whereType<Map>()
          .map((p) => AcademyPostModel.fromJson(Map<String, dynamic>.from(p)))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> registerForTrial({
    required String userId,
    required String academyId,
    required String trialId,
    required String academyName,
    required String myName,
    required String email,
    required String academyEmail,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.acaTrialRegister,
        body: {
          'userId': userId,
          'academyId': academyId,
          'trialId': trialId,
          'academyName': academyName,
          'myName': myName,
          'email': email,
          'academyEmail': academyEmail,
        },
      );
      final data = response['response'] is Map
          ? Map<String, dynamic>.from(response['response'] as Map)
          : response;
      return data['status'] == 1;
    } catch (e) {
      return false;
    }
  }
}
