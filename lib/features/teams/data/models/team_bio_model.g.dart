// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_bio_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamBioModelImpl _$$TeamBioModelImplFromJson(Map<String, dynamic> json) =>
    _$TeamBioModelImpl(
      teamDetails: TeamDetailsModel.fromJson(
          json['teamDetails'] as Map<String, dynamic>),
      players: (json['players'] as List<dynamic>?)
              ?.map((e) => TeamPlayerModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      recentMatches: (json['recentMatches'] as List<dynamic>?)
              ?.map((e) => TeamMatchModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      ratingDetails: json['ratingDetails'] == null
          ? null
          : RatingDetailsModel.fromJson(
              json['ratingDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TeamBioModelImplToJson(_$TeamBioModelImpl instance) =>
    <String, dynamic>{
      'teamDetails': instance.teamDetails,
      'players': instance.players,
      'recentMatches': instance.recentMatches,
      'ratingDetails': instance.ratingDetails,
    };

_$TeamDetailsModelImpl _$$TeamDetailsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TeamDetailsModelImpl(
      teamId: json['teamId'] as String?,
      teamName: json['teamName'] as String?,
      teamShortName: json['teamShortName'] as String?,
      teamImage: json['imageUrl'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      gameType: json['gameType'] as String?,
      gender: json['gender'] as String?,
      ageCategory: json['ageCat'] as String?,
      ageGroup: json['ageGroup'] as String?,
      coachName: json['coachName'] as String?,
      memberCount: (json['memberCount'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      createdOn: (json['createdOn'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$TeamDetailsModelImplToJson(
        _$TeamDetailsModelImpl instance) =>
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
      'coachName': instance.coachName,
      'memberCount': instance.memberCount,
      'rating': instance.rating,
      'createdOn': instance.createdOn,
    };

_$RatingDetailsModelImpl _$$RatingDetailsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RatingDetailsModelImpl(
      teamWork: (json['avgTeamWork'] as num?)?.toInt() ?? 0,
      technical: (json['avgTechnical'] as num?)?.toInt() ?? 0,
      aggressiveness: (json['avgAggressiveness'] as num?)?.toInt() ?? 0,
      tactical: (json['avgTactical'] as num?)?.toInt() ?? 0,
      overall: (json['avgOverall'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$RatingDetailsModelImplToJson(
        _$RatingDetailsModelImpl instance) =>
    <String, dynamic>{
      'avgTeamWork': instance.teamWork,
      'avgTechnical': instance.technical,
      'avgAggressiveness': instance.aggressiveness,
      'avgTactical': instance.tactical,
      'avgOverall': instance.overall,
    };

_$TeamPlayerModelImpl _$$TeamPlayerModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TeamPlayerModelImpl(
      userId: json['userId'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      profileImage: json['imageUrl'] as String?,
      playPosition: json['playPosition'] as String?,
      jerseyNumber: json['teamJerseyNo'] as String?,
    );

Map<String, dynamic> _$$TeamPlayerModelImplToJson(
        _$TeamPlayerModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'imageUrl': instance.profileImage,
      'playPosition': instance.playPosition,
      'teamJerseyNo': instance.jerseyNumber,
    };
