import '../../../../core/constants/api_constants.dart';
import 'club_news_model.dart';
import 'partner_models.dart';

// ─── Helpers ────────────────────────────────────────────────────────────────

int _safeInt(dynamic v) {
  if (v == null) return 0;
  if (v is int) return v;
  return int.tryParse(v.toString()) ?? 0;
}

bool _safeBool(dynamic v) {
  if (v == null) return false;
  if (v is bool) return v;
  return v == 1 || v == '1' || v == 'true';
}

// ─── Confed Info ─────────────────────────────────────────────────────────────

class ConfedInfoModel {
  final String confedId;
  final String confedName;
  final String? formedYear;
  final String? president;
  final String? genSecretary;
  final String? website;
  final String? imageUrl;
  final String? partnerType;
  final bool following;
  final int followCount;
  final int plan;

  const ConfedInfoModel({
    required this.confedId,
    required this.confedName,
    this.formedYear,
    this.president,
    this.genSecretary,
    this.website,
    this.imageUrl,
    this.partnerType,
    this.following = false,
    this.followCount = 0,
    this.plan = 0,
  });

  factory ConfedInfoModel.fromJson(Map<String, dynamic> json) {
    return ConfedInfoModel(
      confedId: json['confedId'] ?? json['_id'] ?? '',
      confedName: json['confedName'] ?? '',
      formedYear: json['formedYear']?.toString(),
      president: json['president']?.toString(),
      genSecretary: json['genSecretary']?.toString(),
      website: json['website']?.toString(),
      imageUrl: json['imageUrl']?.toString(),
      partnerType: json['partnerType']?.toString(),
      following: _safeBool(json['following']),
      followCount: _safeInt(json['followCount']),
      plan: _safeInt(json['plan']),
    );
  }

  String get fullImageUrl => ApiConstants.getImageUrl(imageUrl);

  String get displayPartnerLabel => partnerLabel(partnerType);
}

// ─── Confed FA Item ──────────────────────────────────────────────────────────

class ConfedFAItemModel {
  final String faId;
  final String faName;
  final String? imageUrl;
  final int seq;

  const ConfedFAItemModel({
    required this.faId,
    required this.faName,
    this.imageUrl,
    this.seq = 0,
  });

  factory ConfedFAItemModel.fromJson(Map<String, dynamic> json) {
    return ConfedFAItemModel(
      faId: json['faId'] ?? json['_id'] ?? '',
      faName: json['faName'] ?? '',
      imageUrl: json['imageUrl']?.toString(),
      seq: _safeInt(json['seq']),
    );
  }

  String get fullImageUrl => ApiConstants.getImageUrl(imageUrl);
}

// ─── Confed Competition Item ─────────────────────────────────────────────────

class ConfedCompItemModel {
  final String compId;
  final String compName;
  final String? imageUrl;
  final int seq;

  const ConfedCompItemModel({
    required this.compId,
    required this.compName,
    this.imageUrl,
    this.seq = 0,
  });

  factory ConfedCompItemModel.fromJson(Map<String, dynamic> json) {
    return ConfedCompItemModel(
      compId: json['compId'] ?? json['_id'] ?? '',
      compName: json['compName'] ?? '',
      imageUrl: json['imageUrl']?.toString(),
      seq: _safeInt(json['seq']),
    );
  }

  String get fullImageUrl => ApiConstants.getImageUrl(imageUrl);
}

// ─── Confed Merchandise ──────────────────────────────────────────────────────

class ConfedMerchandiseModel {
  final String prodId;
  final String prodName;
  final String? imageUrl;
  final String? gender;
  final int seq;

  const ConfedMerchandiseModel({
    required this.prodId,
    required this.prodName,
    this.imageUrl,
    this.gender,
    this.seq = 0,
  });

  factory ConfedMerchandiseModel.fromJson(Map<String, dynamic> json) {
    return ConfedMerchandiseModel(
      prodId: json['prodId'] ?? json['_id'] ?? '',
      prodName: json['prodName'] ?? '',
      imageUrl: json['imageUrl']?.toString(),
      gender: json['gender']?.toString(),
      seq: _safeInt(json['seq']),
    );
  }

  String get fullImageUrl => ApiConstants.getImageUrl(imageUrl);
}

// ─── Confed Sponsor ──────────────────────────────────────────────────────────

class ConfedSponsorModel {
  final String sponsorId;
  final String? name;
  final String? logo;
  final String? sponsorType;
  final String? website;
  final int seq;

  const ConfedSponsorModel({
    required this.sponsorId,
    this.name,
    this.logo,
    this.sponsorType,
    this.website,
    this.seq = 0,
  });

  factory ConfedSponsorModel.fromJson(Map<String, dynamic> json) {
    return ConfedSponsorModel(
      sponsorId: json['sponsorId'] ?? json['_id'] ?? '',
      name: json['name']?.toString(),
      logo: json['logo']?.toString(),
      sponsorType: json['sponsorType']?.toString(),
      website: json['website']?.toString(),
      seq: _safeInt(json['seq']),
    );
  }

  String get fullImageUrl => ApiConstants.getImageUrl(logo);
}

// ─── Confed Bio (full response) ──────────────────────────────────────────────

class ConfedBioModel {
  final ConfedInfoModel confedDetails;
  final List<ClubNewsModel> newsList;
  final List<ConfedCompItemModel> compList;
  final List<ConfedFAItemModel> fasList;
  final List<ConfedMerchandiseModel> merchandises;
  final List<ConfedSponsorModel> sponsorList;

  const ConfedBioModel({
    required this.confedDetails,
    this.newsList = const [],
    this.compList = const [],
    this.fasList = const [],
    this.merchandises = const [],
    this.sponsorList = const [],
  });

  factory ConfedBioModel.fromApiJson(Map<String, dynamic> json) {
    final confedDetails = ConfedInfoModel.fromJson(
      json['confedDetails'] as Map<String, dynamic>,
    );

    final newsList = <ClubNewsModel>[];
    if (json['newsList'] is List) {
      for (final n in json['newsList'] as List) {
        if (n is Map<String, dynamic>) {
          newsList.add(ClubNewsModel.fromApiJson(n));
        }
      }
      newsList.sort((a, b) => b.newsDateGmt.compareTo(a.newsDateGmt));
    }

    final compList = <ConfedCompItemModel>[];
    if (json['compList'] is List) {
      for (final c in json['compList'] as List) {
        if (c is Map<String, dynamic>) compList.add(ConfedCompItemModel.fromJson(c));
      }
      compList.sort((a, b) {
        final s = a.seq.compareTo(b.seq);
        return s != 0 ? s : a.compName.compareTo(b.compName);
      });
    }

    final fasList = <ConfedFAItemModel>[];
    if (json['fasList'] is List) {
      for (final f in json['fasList'] as List) {
        if (f is Map<String, dynamic>) fasList.add(ConfedFAItemModel.fromJson(f));
      }
      fasList.sort((a, b) {
        final s = a.seq.compareTo(b.seq);
        return s != 0 ? s : a.faName.compareTo(b.faName);
      });
    }

    final merchandises = <ConfedMerchandiseModel>[];
    if (json['merchandises'] is List) {
      for (final m in json['merchandises'] as List) {
        if (m is Map<String, dynamic>) merchandises.add(ConfedMerchandiseModel.fromJson(m));
      }
      merchandises.sort((a, b) => a.seq.compareTo(b.seq));
    }

    final sponsorList = <ConfedSponsorModel>[];
    if (json['sponsorList'] is List) {
      for (final s in json['sponsorList'] as List) {
        if (s is Map<String, dynamic>) sponsorList.add(ConfedSponsorModel.fromJson(s));
      }
      sponsorList.sort((a, b) => a.seq.compareTo(b.seq));
    }

    return ConfedBioModel(
      confedDetails: confedDetails,
      newsList: newsList,
      compList: compList,
      fasList: fasList,
      merchandises: merchandises,
      sponsorList: sponsorList,
    );
  }
}
