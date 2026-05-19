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

// ═══════════════════════════════════════════════════════════════════════════
// Sponsor Bio Models
// ═══════════════════════════════════════════════════════════════════════════

class SponsorInfoModel {
  final String sponsorId;
  final String sponsorName;
  final String? partnerType;
  final String? website;
  final String? imageUrl;
  final String? headquarter;
  final String? formedYear;
  final String? ceo;
  final String? founders;
  final String? country;
  final String? confed;
  final bool following;
  final int followCount;
  final int plan;

  const SponsorInfoModel({
    required this.sponsorId,
    required this.sponsorName,
    this.partnerType,
    this.website,
    this.imageUrl,
    this.headquarter,
    this.formedYear,
    this.ceo,
    this.founders,
    this.country,
    this.confed,
    this.following = false,
    this.followCount = 0,
    this.plan = 0,
  });

  factory SponsorInfoModel.fromJson(Map<String, dynamic> json) =>
      SponsorInfoModel(
        sponsorId: json['sponsorId'] ?? json['_id'] ?? '',
        sponsorName: json['sponsorName'] ?? '',
        partnerType: json['partnerType']?.toString(),
        website: json['website']?.toString(),
        imageUrl: json['imageUrl']?.toString(),
        headquarter: json['headquarter']?.toString(),
        formedYear: json['formedYear']?.toString(),
        ceo: json['ceo']?.toString(),
        founders: json['founders']?.toString(),
        country: json['country']?.toString(),
        confed: json['confed']?.toString(),
        following: _safeBool(json['following']),
        followCount: _safeInt(json['followCount']),
        plan: _safeInt(json['plan']),
      );

  String get fullImageUrl => ApiConstants.getImageUrl(imageUrl);
  String get displayPartnerLabel => partnerLabel(partnerType);
}

class SponsorMerchandiseModel {
  final String prodId;
  final String prodName;
  final String? imageUrl;
  final String? link;
  final String? description;
  final int seq;

  const SponsorMerchandiseModel({
    required this.prodId,
    required this.prodName,
    this.imageUrl,
    this.link,
    this.description,
    this.seq = 0,
  });

  factory SponsorMerchandiseModel.fromJson(Map<String, dynamic> json) =>
      SponsorMerchandiseModel(
        prodId: json['prodId'] ?? json['_id'] ?? '',
        prodName: json['prodName'] ?? '',
        imageUrl: json['imageUrl']?.toString(),
        link: json['link']?.toString(),
        description: json['description']?.toString(),
        seq: _safeInt(json['seq']),
      );

  String get fullImageUrl => ApiConstants.getImageUrl(imageUrl);
}

class SponsorBioModel {
  final SponsorInfoModel details;
  final List<SponsorMerchandiseModel> merchandises;
  final List<ClubNewsModel> newsList;

  const SponsorBioModel({
    required this.details,
    required this.merchandises,
    required this.newsList,
  });

  factory SponsorBioModel.fromApiJson(Map<String, dynamic> json) {
    final details = json['sponDetails'] != null
        ? SponsorInfoModel.fromJson(
            json['sponDetails'] as Map<String, dynamic>)
        : SponsorInfoModel(sponsorId: '', sponsorName: '');

    final merchandises = (json['merchandises'] as List?)
            ?.whereType<Map<String, dynamic>>()
            .map(SponsorMerchandiseModel.fromJson)
            .toList() ??
        [];
    merchandises.sort((a, b) => b.seq.compareTo(a.seq));

    final newsList = (json['newsList'] as List?)
            ?.whereType<Map<String, dynamic>>()
            .map(ClubNewsModel.fromApiJson)
            .toList() ??
        [];
    newsList.sort(
        (a, b) => (b.newsDateGmt).compareTo(a.newsDateGmt));

    return SponsorBioModel(
      details: details,
      merchandises: merchandises,
      newsList: newsList,
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Charity Bio Models
// ═══════════════════════════════════════════════════════════════════════════

class CharityInfoModel {
  final String charityId;
  final String charityName;
  final String? partnerType;
  final String? website;
  final String? imageUrl;
  final String? formedYear;
  final String? president;
  final String? chairman;
  final String? ceo;
  final String? funders;
  final String? country;
  final String? confed;
  final bool following;
  final int followCount;
  final int plan;

  const CharityInfoModel({
    required this.charityId,
    required this.charityName,
    this.partnerType,
    this.website,
    this.imageUrl,
    this.formedYear,
    this.president,
    this.chairman,
    this.ceo,
    this.funders,
    this.country,
    this.confed,
    this.following = false,
    this.followCount = 0,
    this.plan = 0,
  });

  factory CharityInfoModel.fromJson(Map<String, dynamic> json) =>
      CharityInfoModel(
        charityId: json['charityId'] ?? json['_id'] ?? '',
        charityName: json['charityName'] ?? '',
        partnerType: json['partnerType']?.toString(),
        website: json['website']?.toString(),
        imageUrl: json['imageUrl']?.toString(),
        formedYear: json['formedYear']?.toString(),
        president: json['president']?.toString(),
        chairman: json['chairMan']?.toString(),
        ceo: json['ceo']?.toString(),
        funders: json['funders']?.toString(),
        country: json['country']?.toString(),
        confed: json['confed']?.toString(),
        following: _safeBool(json['following']),
        followCount: _safeInt(json['followCount']),
        plan: _safeInt(json['plan']),
      );

  String get fullImageUrl => ApiConstants.getImageUrl(imageUrl);
  String get displayPartnerLabel => partnerLabel(partnerType);
}

class CharityBioAreaModel {
  final String? bio;
  final String? imageUrl;

  const CharityBioAreaModel({this.bio, this.imageUrl});

  factory CharityBioAreaModel.fromJson(Map<String, dynamic> json) =>
      CharityBioAreaModel(
        bio: json['bio']?.toString(),
        imageUrl: json['imageUrl']?.toString(),
      );

  String get fullImageUrl => ApiConstants.getImageUrl(imageUrl);
}

class CharityBioModel {
  final CharityInfoModel details;
  final CharityBioAreaModel? bioArea;
  final List<ClubNewsModel> newsList;

  const CharityBioModel({
    required this.details,
    this.bioArea,
    required this.newsList,
  });

  factory CharityBioModel.fromApiJson(Map<String, dynamic> json) {
    final details = json['charityDetails'] != null
        ? CharityInfoModel.fromJson(
            json['charityDetails'] as Map<String, dynamic>)
        : CharityInfoModel(charityId: '', charityName: '');

    final bioArea = json['bioArea'] != null
        ? CharityBioAreaModel.fromJson(
            json['bioArea'] as Map<String, dynamic>)
        : null;

    final newsList = (json['newsList'] as List?)
            ?.whereType<Map<String, dynamic>>()
            .map(ClubNewsModel.fromApiJson)
            .toList() ??
        [];
    newsList.sort(
        (a, b) => (b.newsDateGmt).compareTo(a.newsDateGmt));

    return CharityBioModel(
      details: details,
      bioArea: bioArea,
      newsList: newsList,
    );
  }
}
