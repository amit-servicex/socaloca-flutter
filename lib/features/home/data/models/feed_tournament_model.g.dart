// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_tournament_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedTournamentModelImpl _$$FeedTournamentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FeedTournamentModelImpl(
      feedId: json['feedId'] as String?,
      feedType: json['feedType'] as String?,
      tournamentId: json['tournamentId'] as String?,
      tmntName: json['name'] as String?,
      imageUrl: json['logo'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      status: json['status'] as String?,
      teamsCount: (json['teamCount'] as num?)?.toInt() ?? 0,
      tmntType: json['tmntType'] as String?,
      country: json['country'] as String?,
      city: json['location'] as String?,
      ageGroup: json['ageGroup'] as String?,
      gender: json['gender'] as String?,
      gameType: json['gameType'] as String?,
      visibility: json['visibility'] as String?,
      venue: json['venue'] as String?,
      ageCat: json['ageCat'] as String?,
      teamPlayerType: json['teamPlayerType'] as String?,
      teamPlayerLimit: (json['teamPlayerLimit'] as num?)?.toInt(),
      createdOn: (json['createdOn'] as num?)?.toInt(),
      following: json['following'] as bool? ?? false,
      comments: json['comments'] as List<dynamic>? ?? const [],
    );

Map<String, dynamic> _$$FeedTournamentModelImplToJson(
        _$FeedTournamentModelImpl instance) =>
    <String, dynamic>{
      'feedId': instance.feedId,
      'feedType': instance.feedType,
      'tournamentId': instance.tournamentId,
      'name': instance.tmntName,
      'logo': instance.imageUrl,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'status': instance.status,
      'teamCount': instance.teamsCount,
      'tmntType': instance.tmntType,
      'country': instance.country,
      'location': instance.city,
      'ageGroup': instance.ageGroup,
      'gender': instance.gender,
      'gameType': instance.gameType,
      'visibility': instance.visibility,
      'venue': instance.venue,
      'ageCat': instance.ageCat,
      'teamPlayerType': instance.teamPlayerType,
      'teamPlayerLimit': instance.teamPlayerLimit,
      'createdOn': instance.createdOn,
      'following': instance.following,
      'comments': instance.comments,
    };
