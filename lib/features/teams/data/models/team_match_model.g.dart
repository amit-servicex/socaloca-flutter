// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamMatchModelImpl _$$TeamMatchModelImplFromJson(Map<String, dynamic> json) =>
    _$TeamMatchModelImpl(
      matchId: json['matchId'] as String?,
      matchDate: json['matchDate'] as String?,
      matchTime: json['matchTime'] as String?,
      gameType: json['gameType'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      teams: (json['teams'] as List<dynamic>?)
              ?.map(
                  (e) => TeamMatchTeamModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      score: json['score'] == null
          ? null
          : TeamMatchScoreModel.fromJson(json['score'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TeamMatchModelImplToJson(
        _$TeamMatchModelImpl instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'matchDate': instance.matchDate,
      'matchTime': instance.matchTime,
      'gameType': instance.gameType,
      'country': instance.country,
      'city': instance.city,
      'teams': instance.teams,
      'score': instance.score,
    };

_$TeamMatchTeamModelImpl _$$TeamMatchTeamModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TeamMatchTeamModelImpl(
      teamId: json['teamId'] as String?,
      teamName: json['teamName'] as String?,
      teamShortName: json['teamShortName'] as String?,
      teamImage: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$TeamMatchTeamModelImplToJson(
        _$TeamMatchTeamModelImpl instance) =>
    <String, dynamic>{
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'teamShortName': instance.teamShortName,
      'imageUrl': instance.teamImage,
    };

_$TeamMatchScoreModelImpl _$$TeamMatchScoreModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TeamMatchScoreModelImpl(
      team1: (json['team1'] as num?)?.toInt() ?? 0,
      team2: (json['team2'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$TeamMatchScoreModelImplToJson(
        _$TeamMatchScoreModelImpl instance) =>
    <String, dynamic>{
      'team1': instance.team1,
      'team2': instance.team2,
    };
