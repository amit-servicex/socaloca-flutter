// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClubTeamModelImpl _$$ClubTeamModelImplFromJson(Map<String, dynamic> json) =>
    _$ClubTeamModelImpl(
      teamId: json['teamId'] as String,
      id: json['_id'] as String?,
      createdBy: json['createdBy'] as String?,
      clubId: json['clubId'] as String?,
      teamName: json['teamName'] as String?,
      teamShortName: json['teamShortName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      fa: json['fa'] as String?,
      clubTeam: json['clubTeam'] as bool? ?? false,
      seq: (json['seq'] as num?)?.toInt() ?? 0,
      gender: json['gender'] as String?,
      ageGroup: json['ageGroup'] as String?,
      ageCat: json['ageCat'] as String?,
      gameType: json['gameType'] as String?,
      createdOn: (json['createdOn'] as num?)?.toInt(),
      followCount: (json['followCount'] as num?)?.toInt() ?? 0,
      archive: json['archive'] as bool? ?? false,
      admins: (json['admins'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      teamPlayers: (json['teamPlayers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      coaches: (json['coaches'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      managers: (json['managers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      directTeam: json['directTeam'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      ratingCounter: (json['ratingCounter'] as num?)?.toInt() ?? 0,
      isDelete: json['isDelete'] as bool? ?? false,
      lastUpdateBy: json['lastUpdateBy'] as String?,
      lastUpdated: (json['lastUpdated'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ClubTeamModelImplToJson(_$ClubTeamModelImpl instance) =>
    <String, dynamic>{
      'teamId': instance.teamId,
      '_id': instance.id,
      'createdBy': instance.createdBy,
      'clubId': instance.clubId,
      'teamName': instance.teamName,
      'teamShortName': instance.teamShortName,
      'imageUrl': instance.imageUrl,
      'country': instance.country,
      'city': instance.city,
      'fa': instance.fa,
      'clubTeam': instance.clubTeam,
      'seq': instance.seq,
      'gender': instance.gender,
      'ageGroup': instance.ageGroup,
      'ageCat': instance.ageCat,
      'gameType': instance.gameType,
      'createdOn': instance.createdOn,
      'followCount': instance.followCount,
      'archive': instance.archive,
      'admins': instance.admins,
      'teamPlayers': instance.teamPlayers,
      'coaches': instance.coaches,
      'managers': instance.managers,
      'directTeam': instance.directTeam,
      'rating': instance.rating,
      'ratingCounter': instance.ratingCounter,
      'isDelete': instance.isDelete,
      'lastUpdateBy': instance.lastUpdateBy,
      'lastUpdated': instance.lastUpdated,
    };
