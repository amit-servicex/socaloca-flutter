// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClubUserModelImpl _$$ClubUserModelImplFromJson(Map<String, dynamic> json) =>
    _$ClubUserModelImpl(
      clubId: json['clubId'] as String?,
      clubName: json['clubName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      coverImage: json['coverImage'] as String?,
      nickName: json['nickName'] as String?,
      formedIn: json['formedYear'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      stadium: json['stadium'] as String?,
      manager: json['manager'] as String?,
      league: json['league'] as String?,
      competitions: json['competitions'] as String?,
      website: json['website'] as String?,
      followCount: (json['followCount'] as num?)?.toInt(),
      partnerType: json['partnerType'] as String?,
      isPartner: json['isPartner'] as bool?,
      liveTrial: json['liveTrial'] as bool?,
      homeKit: json['homeKit'] as String?,
      awayKit: json['awayKit'] as String?,
      thirdKit: json['thirdKit'] as String?,
      userId: json['userId'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      adminBy: json['adminBy'] as String?,
      accepted: json['accepted'] as String?,
    );

Map<String, dynamic> _$$ClubUserModelImplToJson(_$ClubUserModelImpl instance) =>
    <String, dynamic>{
      'clubId': instance.clubId,
      'clubName': instance.clubName,
      'imageUrl': instance.imageUrl,
      'coverImage': instance.coverImage,
      'nickName': instance.nickName,
      'formedYear': instance.formedIn,
      'country': instance.country,
      'city': instance.city,
      'stadium': instance.stadium,
      'manager': instance.manager,
      'league': instance.league,
      'competitions': instance.competitions,
      'website': instance.website,
      'followCount': instance.followCount,
      'partnerType': instance.partnerType,
      'isPartner': instance.isPartner,
      'liveTrial': instance.liveTrial,
      'homeKit': instance.homeKit,
      'awayKit': instance.awayKit,
      'thirdKit': instance.thirdKit,
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'adminBy': instance.adminBy,
      'accepted': instance.accepted,
    };
