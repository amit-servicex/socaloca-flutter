import '../../../../core/constants/api_constants.dart';
import 'club_bio_model.dart';
import 'club_news_model.dart';
import 'club_sponsor_model.dart';

// ─── FA Info ──────────────────────────────────────────────────────────────

class FaInfoModel {
  final String faId;
  final String faName;
  final String? confed;
  final String? formedYear;
  final String? country;
  final String? city;
  final String? stadium;
  final String? president;
  final String? genSecretary;
  final String? imageUrl;
  final String? website;
  final String? partnerType;
  final bool following;
  final int followCount;
  final bool trialBadge;
  final int plan;

  const FaInfoModel({
    required this.faId,
    required this.faName,
    this.confed,
    this.formedYear,
    this.country,
    this.city,
    this.stadium,
    this.president,
    this.genSecretary,
    this.imageUrl,
    this.website,
    this.partnerType,
    this.following = false,
    this.followCount = 0,
    this.trialBadge = false,
    this.plan = 0,
  });

  factory FaInfoModel.fromJson(Map<String, dynamic> json) {
    int safeInt(dynamic v) {
      if (v == null) return 0;
      if (v is int) return v;
      return int.tryParse(v.toString()) ?? 0;
    }

    bool safeBool(dynamic v) {
      if (v == null) return false;
      if (v is bool) return v;
      return v == 1 || v == '1' || v == 'true';
    }

    return FaInfoModel(
      faId: json['faId'] ?? json['_id'] ?? '',
      faName: json['faName'] ?? '',
      confed: json['confed']?.toString(),
      formedYear: json['formedYear']?.toString(),
      country: json['country']?.toString(),
      city: json['city']?.toString(),
      stadium: json['stadium']?.toString(),
      president: json['president']?.toString(),
      genSecretary: json['genSecretary']?.toString(),
      imageUrl: json['imageUrl']?.toString(),
      website: json['website']?.toString(),
      partnerType: json['partnerType']?.toString(),
      following: safeBool(json['following']),
      followCount: safeInt(json['followCount']),
      trialBadge: safeBool(json['trialBadge']),
      plan: safeInt(json['plan']),
    );
  }

  String get fullImageUrl => ApiConstants.getImageUrl(imageUrl);

  String get displayPartnerLabel {
    final t = partnerType;
    if (t == null || t.isEmpty || t.toLowerCase() == 'nopartner')
      return 'Non-Partner';
    return '${t[0].toUpperCase()}${t.substring(1)} Partner';
  }
}

// ─── FA Competition ───────────────────────────────────────────────────────

class FaCompModel {
  final String compId;
  final String compName;
  final String? imageUrl;
  final int seq;

  const FaCompModel({
    required this.compId,
    required this.compName,
    this.imageUrl,
    this.seq = 0,
  });

  factory FaCompModel.fromJson(Map<String, dynamic> json) {
    return FaCompModel(
      compId: json['compId'] ?? json['_id'] ?? '',
      compName: json['compName'] ?? '',
      imageUrl: json['imageUrl']?.toString(),
      seq: (json['seq'] is int)
          ? json['seq']
          : int.tryParse(json['seq']?.toString() ?? '0') ?? 0,
    );
  }

  String get fullImageUrl => ApiConstants.getImageUrl(imageUrl);
}

// ─── FA Team ──────────────────────────────────────────────────────────────

class FaTeamModel {
  final String teamId;
  final String teamName;
  final String? imageUrl;
  final String? gender;
  final String? ageGroup;
  final String? ageCat;
  final int seq;

  const FaTeamModel({
    required this.teamId,
    required this.teamName,
    this.imageUrl,
    this.gender,
    this.ageGroup,
    this.ageCat,
    this.seq = 0,
  });

  factory FaTeamModel.fromJson(Map<String, dynamic> json) {
    return FaTeamModel(
      teamId: json['teamId'] ?? json['_id'] ?? '',
      teamName: json['teamName'] ?? '',
      imageUrl: json['imageUrl']?.toString(),
      gender: json['gender']?.toString(),
      ageGroup: json['ageGroup']?.toString(),
      ageCat: json['ageCat']?.toString(),
      seq: (json['seq'] is int)
          ? json['seq']
          : int.tryParse(json['seq']?.toString() ?? '0') ?? 0,
    );
  }

  String get fullImageUrl => ApiConstants.getImageUrl(imageUrl);

  String get teamTypeLabel {
    final parts = <String>[];
    if (gender != null && gender!.isNotEmpty) parts.add(gender!);
    if (ageGroup != null && ageGroup!.isNotEmpty) parts.add(ageGroup!);
    return parts.join(' · ');
  }
}

// ─── FA Bio (full response) ───────────────────────────────────────────────

class FaBioModel {
  final FaInfoModel faDetails;
  final ClubTrialStatusModel? trialDetails;
  final List<ClubNewsModel> newsList;
  final List<FaCompModel> compList;
  final List<FaTeamModel> teamList;
  final List<ClubSponsorModel> sponsorList;

  const FaBioModel({
    required this.faDetails,
    this.trialDetails,
    this.newsList = const [],
    this.compList = const [],
    this.teamList = const [],
    this.sponsorList = const [],
  });

  factory FaBioModel.fromApiJson(Map<String, dynamic> json) {
    final faDetails = FaInfoModel.fromJson(
      json['faDetails'] as Map<String, dynamic>,
    );

    ClubTrialStatusModel? trialDetails;
    if (json['trialDetails'] != null) {
      final td = json['trialDetails'] as Map<String, dynamic>;
      trialDetails = ClubTrialStatusModel(
        trialBadge: td['trialBadge'] == true,
        isRegisterBtn: td['isRegisterBtn'] == true,
        isRegistered: td['isRegistered'] == true,
        isRegistrationClosed: td['isRegistrationClosed'] == true,
      );
    }

    final newsList = <ClubNewsModel>[];
    if (json['newsList'] is List) {
      for (final n in json['newsList'] as List) {
        if (n is Map<String, dynamic>) {
          newsList.add(ClubNewsModel.fromApiJson(n));
        }
      }
      newsList.sort((a, b) => b.newsDateGmt.compareTo(a.newsDateGmt));
    }

    final compList = <FaCompModel>[];
    if (json['compList'] is List) {
      for (final c in json['compList'] as List) {
        if (c is Map<String, dynamic>) compList.add(FaCompModel.fromJson(c));
      }
      compList.sort((a, b) {
        final s = a.seq.compareTo(b.seq);
        return s != 0 ? s : a.compName.compareTo(b.compName);
      });
    }

    final teamList = <FaTeamModel>[];
    if (json['teamList'] is List) {
      for (final t in json['teamList'] as List) {
        if (t is Map<String, dynamic>) teamList.add(FaTeamModel.fromJson(t));
      }
      teamList.sort((a, b) {
        final s = a.seq.compareTo(b.seq);
        return s != 0 ? s : a.teamName.compareTo(b.teamName);
      });
    }

    final sponsorList = <ClubSponsorModel>[];
    if (json['sponsorList'] is List) {
      for (final s in json['sponsorList'] as List) {
        if (s is Map<String, dynamic>) {
          sponsorList.add(ClubSponsorModel.fromApiJson(s));
        }
      }
    }

    return FaBioModel(
      faDetails: faDetails,
      trialDetails: trialDetails,
      newsList: newsList,
      compList: compList,
      teamList: teamList,
      sponsorList: sponsorList,
    );
  }
}
