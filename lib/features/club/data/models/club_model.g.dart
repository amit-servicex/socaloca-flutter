// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClubModelImpl _$$ClubModelImplFromJson(Map<String, dynamic> json) =>
    _$ClubModelImpl(
      clubId: json['clubId'] as String,
      id: json['_id'] as String?,
      clubName: json['clubName'] as String,
      partnerType: json['partnerType'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      nickName: json['nickName'] as String?,
      formedYear: json['formedYear'] as String?,
      manager: json['manager'] as String?,
      confed: json['confed'] as String?,
      league: json['league'] as String?,
      website: json['website'] as String?,
      imageUrl: json['imageUrl'] as String?,
      homeKit: json['homeKit'] as String?,
      awayKit: json['awayKit'] as String?,
      thirdKit: json['thirdKit'] as String?,
      orgFifaId: json['orgFifaId'] as String?,
      following: json['following'] as bool? ?? false,
      trialBadge: json['trialBadge'] as bool? ?? false,
      isPartner: json['isPartner'] as bool? ?? false,
      followCount: (json['followCount'] as num?)?.toInt() ?? 0,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      plan: (json['plan'] as num?)?.toInt() ?? 0,
      stadiums: (json['stadiums'] as List<dynamic>?)
              ?.map((e) => StadiumModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      comps:
          (json['comps'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$$ClubModelImplToJson(_$ClubModelImpl instance) =>
    <String, dynamic>{
      'clubId': instance.clubId,
      '_id': instance.id,
      'clubName': instance.clubName,
      'partnerType': instance.partnerType,
      'country': instance.country,
      'city': instance.city,
      'nickName': instance.nickName,
      'formedYear': instance.formedYear,
      'manager': instance.manager,
      'confed': instance.confed,
      'league': instance.league,
      'website': instance.website,
      'imageUrl': instance.imageUrl,
      'homeKit': instance.homeKit,
      'awayKit': instance.awayKit,
      'thirdKit': instance.thirdKit,
      'orgFifaId': instance.orgFifaId,
      'following': instance.following,
      'trialBadge': instance.trialBadge,
      'isPartner': instance.isPartner,
      'followCount': instance.followCount,
      'likeCount': instance.likeCount,
      'plan': instance.plan,
      'stadiums': instance.stadiums,
      'comps': instance.comps,
    };

_$StadiumModelImpl _$$StadiumModelImplFromJson(Map<String, dynamic> json) =>
    _$StadiumModelImpl(
      name: json['name'] as String?,
      seq: (json['seq'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$StadiumModelImplToJson(_$StadiumModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'seq': instance.seq,
    };
