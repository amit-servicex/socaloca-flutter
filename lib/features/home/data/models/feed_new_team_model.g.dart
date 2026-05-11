// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_new_team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedNewTeamModelImpl _$$FeedNewTeamModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FeedNewTeamModelImpl(
      id: json['_id'] as String?,
      teamId: json['teamId'] as String?,
      teamName: json['teamName'] as String?,
      teamLogo: json['imageUrl'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      memberCount: (json['memberCount'] as num?)?.toInt() ?? 0,
      createdOn: (json['createdOn'] as num?)?.toInt(),
      teamType: json['gameType'] as String?,
    );

Map<String, dynamic> _$$FeedNewTeamModelImplToJson(
        _$FeedNewTeamModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'imageUrl': instance.teamLogo,
      'country': instance.country,
      'city': instance.city,
      'memberCount': instance.memberCount,
      'createdOn': instance.createdOn,
      'gameType': instance.teamType,
    };
