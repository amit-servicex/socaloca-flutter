// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamModelImpl _$$TeamModelImplFromJson(Map<String, dynamic> json) =>
    _$TeamModelImpl(
      teamId: json['teamId'] as String,
      teamName: json['teamName'] as String,
      teamShortName: json['teamShortName'] as String?,
      teamImage: json['imageUrl'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      gameType: json['gameType'] as String?,
      gender: json['gender'] as String?,
      ageCategory: json['ageCat'] as String?,
      ageGroup: json['ageGroup'] as String?,
      memberCount: (json['memberCount'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      createdOn: (json['createdOn'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$TeamModelImplToJson(_$TeamModelImpl instance) =>
    <String, dynamic>{
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'teamShortName': instance.teamShortName,
      'imageUrl': instance.teamImage,
      'country': instance.country,
      'city': instance.city,
      'gameType': instance.gameType,
      'gender': instance.gender,
      'ageCat': instance.ageCategory,
      'ageGroup': instance.ageGroup,
      'memberCount': instance.memberCount,
      'rating': instance.rating,
      'createdOn': instance.createdOn,
    };
