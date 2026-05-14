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

  Future<AcademyBioData?> getAcademyBio({
    required String userId,
    required String academyId,
  }) async {
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getAcademyBio,
        body: {'userId': userId, 'academyId': academyId},
      );

      final data = response['response'] as Map<String, dynamic>? ?? response;
      if (data['status'] != 1 || data['details'] == null) return null;

      final details = data['details'] as Map<String, dynamic>;

      String? joinedStatus;
      if (details['joinDetails'] != null) {
        final jd = details['joinDetails'] as Map<String, dynamic>;
        joinedStatus = jd['joined'] as String?;
      }

      AcademyDetailModel? academyDetails;
      if (details['academyDetails'] != null) {
        academyDetails = AcademyDetailModel.fromJson(
            details['academyDetails'] as Map<String, dynamic>);
      }

      final banners = <AcademyBannerModel>[];
      if (details['banners'] is List) {
        for (final b in details['banners'] as List) {
          final bm = AcademyBannerModel.fromJson(b as Map<String, dynamic>);
          if (bm.imageUrl.isNotEmpty) banners.add(bm);
        }
      }

      AcademyTrialStatusModel? trialDetails;
      if (details['trialDetails'] != null) {
        trialDetails = AcademyTrialStatusModel.fromJson(
            details['trialDetails'] as Map<String, dynamic>);
      }

      final newsList = <AcademyNewsModel>[];
      if (details['newsList'] is List) {
        for (final n in details['newsList'] as List) {
          newsList.add(AcademyNewsModel.fromJson(n as Map<String, dynamic>));
        }
      }

      final postList = <AcademyPostModel>[];
      if (details['postList'] is List) {
        for (final p in details['postList'] as List) {
          postList.add(AcademyPostModel.fromJson(p as Map<String, dynamic>));
        }
      }

      final sponsorList = <AcademySponsorModel>[];
      if (details['sponsorList'] is List) {
        for (final s in details['sponsorList'] as List) {
          sponsorList
              .add(AcademySponsorModel.fromJson(s as Map<String, dynamic>));
        }
      }

      final teams = <AcademyTeamModel>[];
      if (details['teams'] is List) {
        for (final t in details['teams'] as List) {
          teams.add(AcademyTeamModel.fromJson(t as Map<String, dynamic>));
        }
      }

      final skillVdos = <AcademyPostModel>[];
      if (details['skillVdos'] is List) {
        for (final v in details['skillVdos'] as List) {
          skillVdos.add(AcademyPostModel.fromJson(v as Map<String, dynamic>));
        }
        skillVdos.sort((a, b) => b.addedOn.compareTo(a.addedOn));
      }

      final matchVdos = <AcademyPostModel>[];
      if (details['matchVdos'] is List) {
        for (final v in details['matchVdos'] as List) {
          matchVdos.add(AcademyPostModel.fromJson(v as Map<String, dynamic>));
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
      final data = response['response'] as Map<String, dynamic>? ?? response;
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
      final data = response['response'] as Map<String, dynamic>? ?? response;
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
      final data = response['response'] as Map<String, dynamic>? ?? response;
      if (data['status'] != 1 || data['posts'] == null) return [];
      final posts = data['posts'] as List;
      return posts
          .map((p) => AcademyPostModel.fromJson(p as Map<String, dynamic>))
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
      final data = response['response'] as Map<String, dynamic>? ?? response;
      return data['status'] == 1;
    } catch (e) {
      return false;
    }
  }
}
