import '../../../../core/constants/api_constants.dart';

// ─── Shared helpers ────────────────────────────────────────────────────────

int _parseInt(dynamic v) {
  if (v == null) return 0;
  if (v is int) return v;
  return int.tryParse(v.toString()) ?? 0;
}

bool _parseBool(dynamic v) {
  if (v == null) return false;
  if (v is bool) return v;
  return v == 1 || v == '1' || v == 'true';
}

String partnerLabel(String? partnerType) {
  final t = partnerType;
  if (t == null || t.isEmpty || t.toLowerCase() == 'nopartner') {
    return 'Non-Partner';
  }
  return '${t[0].toUpperCase()}${t.substring(1)} Partner';
}

// ─── FA ────────────────────────────────────────────────────────────────────

class FaModel {
  final String faId;
  final String faName;
  final String? imageUrl;
  final String? country;
  final String? confed;
  final String? partnerType;
  final bool trialBadge;
  final bool following;
  final int plan;

  const FaModel({
    required this.faId,
    required this.faName,
    this.imageUrl,
    this.country,
    this.confed,
    this.partnerType,
    this.trialBadge = false,
    this.following = false,
    this.plan = 0,
  });

  factory FaModel.fromJson(Map<String, dynamic> json) => FaModel(
        faId: json['faId'] ?? json['_id'] ?? '',
        faName: json['faName'] ?? '',
        imageUrl: json['imageUrl'],
        country: json['country'],
        confed: json['confed'],
        partnerType: json['partnerType'],
        trialBadge: _parseBool(json['trialBadge']),
        following: _parseBool(json['following']),
        plan: _parseInt(json['plan']),
      );

  String get fullImageUrl => ApiConstants.getImageUrl(imageUrl);
  String get displayPartnerLabel => partnerLabel(partnerType);
}

// ─── Confederation ─────────────────────────────────────────────────────────

class ConfedModel {
  final String confedId;
  final String confedName;
  final String? imageUrl;
  final String? country;
  final String? partnerType;
  final bool following;
  final int plan;

  const ConfedModel({
    required this.confedId,
    required this.confedName,
    this.imageUrl,
    this.country,
    this.partnerType,
    this.following = false,
    this.plan = 0,
  });

  factory ConfedModel.fromJson(Map<String, dynamic> json) => ConfedModel(
        confedId: json['confedId'] ?? json['_id'] ?? '',
        confedName: json['confedName'] ?? '',
        imageUrl: json['imageUrl'],
        country: json['country'],
        partnerType: json['partnerType'],
        following: _parseBool(json['following']),
        plan: _parseInt(json['plan']),
      );

  String get fullImageUrl => ApiConstants.getImageUrl(imageUrl);
  String get displayPartnerLabel => partnerLabel(partnerType);
}

// ─── Sponsor ───────────────────────────────────────────────────────────────

class SponsorModel {
  final String sponsorId;
  final String sponsorName;
  final String? imageUrl;
  final String? country;
  final String? partnerType;
  final bool following;
  final int plan;

  const SponsorModel({
    required this.sponsorId,
    required this.sponsorName,
    this.imageUrl,
    this.country,
    this.partnerType,
    this.following = false,
    this.plan = 0,
  });

  factory SponsorModel.fromJson(Map<String, dynamic> json) => SponsorModel(
        sponsorId: json['sponsorId'] ?? json['_id'] ?? '',
        sponsorName: json['sponsorName'] ?? '',
        imageUrl: json['imageUrl'],
        country: json['country'],
        partnerType: json['partnerType'],
        following: _parseBool(json['following']),
        plan: _parseInt(json['plan']),
      );

  String get fullImageUrl => ApiConstants.getImageUrl(imageUrl);
  String get displayPartnerLabel => partnerLabel(partnerType);
}

// ─── Charity / NGO ─────────────────────────────────────────────────────────

class CharityModel {
  final String charityId;
  final String charityName;
  final String? imageUrl;
  final String? country;
  final String? partnerType;
  final bool following;
  final int plan;

  const CharityModel({
    required this.charityId,
    required this.charityName,
    this.imageUrl,
    this.country,
    this.partnerType,
    this.following = false,
    this.plan = 0,
  });

  factory CharityModel.fromJson(Map<String, dynamic> json) => CharityModel(
        charityId: json['charityId'] ?? json['_id'] ?? '',
        charityName: json['charityName'] ?? '',
        imageUrl: json['imageUrl'],
        country: json['country'],
        partnerType: json['partnerType'],
        following: _parseBool(json['following']),
        plan: _parseInt(json['plan']),
      );

  String get fullImageUrl => ApiConstants.getImageUrl(imageUrl);
  String get displayPartnerLabel => partnerLabel(partnerType);
}
