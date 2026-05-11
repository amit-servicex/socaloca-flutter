// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedTeamModelImpl _$$FeedTeamModelImplFromJson(Map<String, dynamic> json) =>
    _$FeedTeamModelImpl(
      id: json['teamId'] as String,
      name: json['teamName'] as String,
      logo: json['teamLogo'] as String?,
      coverImage: json['teamCoverImage'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      adminId: json['adminId'] as String?,
      adminName: json['adminName'] as String?,
      bio: json['bio'] as String?,
      playersCount: (json['playerCount'] as num?)?.toInt() ?? 0,
      matchesCount: (json['matchCount'] as num?)?.toInt() ?? 0,
      isFollowing: json['followedByMe'] as bool? ?? false,
      followersCount: (json['followerCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$FeedTeamModelImplToJson(_$FeedTeamModelImpl instance) =>
    <String, dynamic>{
      'teamId': instance.id,
      'teamName': instance.name,
      'teamLogo': instance.logo,
      'teamCoverImage': instance.coverImage,
      'country': instance.country,
      'city': instance.city,
      'adminId': instance.adminId,
      'adminName': instance.adminName,
      'bio': instance.bio,
      'playerCount': instance.playersCount,
      'matchCount': instance.matchesCount,
      'followedByMe': instance.isFollowing,
      'followerCount': instance.followersCount,
    };
