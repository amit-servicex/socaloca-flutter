// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MatchModelImpl _$$MatchModelImplFromJson(Map<String, dynamic> json) =>
    _$MatchModelImpl(
      id: json['id'] as String,
      homeTeamId: json['homeTeamId'] as String,
      awayTeamId: json['awayTeamId'] as String,
      homeTeamName: json['homeTeamName'] as String,
      awayTeamName: json['awayTeamName'] as String,
      homeTeamLogo: json['homeTeamLogo'] as String?,
      awayTeamLogo: json['awayTeamLogo'] as String?,
      matchDate: json['matchDate'] as String?,
      matchTime: json['matchTime'] as String?,
      venue: json['venue'] as String?,
      status: json['status'] as String?,
      score: json['score'] == null
          ? null
          : MatchScore.fromJson(json['score'] as Map<String, dynamic>),
      tournamentId: json['tournamentId'] as String?,
      tournamentName: json['tournamentName'] as String?,
      cupId: json['cupId'] as String?,
      isOneOff: json['isOneOff'] as bool?,
      events: (json['events'] as List<dynamic>?)
              ?.map((e) => MatchEvent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      refereeId: json['refereeId'] as String?,
      refereeName: json['refereeName'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MatchModelImplToJson(_$MatchModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'homeTeamId': instance.homeTeamId,
      'awayTeamId': instance.awayTeamId,
      'homeTeamName': instance.homeTeamName,
      'awayTeamName': instance.awayTeamName,
      'homeTeamLogo': instance.homeTeamLogo,
      'awayTeamLogo': instance.awayTeamLogo,
      'matchDate': instance.matchDate,
      'matchTime': instance.matchTime,
      'venue': instance.venue,
      'status': instance.status,
      'score': instance.score,
      'tournamentId': instance.tournamentId,
      'tournamentName': instance.tournamentName,
      'cupId': instance.cupId,
      'isOneOff': instance.isOneOff,
      'events': instance.events,
      'refereeId': instance.refereeId,
      'refereeName': instance.refereeName,
      'duration': instance.duration,
    };

_$MatchScoreImpl _$$MatchScoreImplFromJson(Map<String, dynamic> json) =>
    _$MatchScoreImpl(
      homeGoals: (json['homeGoals'] as num?)?.toInt() ?? 0,
      awayGoals: (json['awayGoals'] as num?)?.toInt() ?? 0,
      homeExtraTime: (json['homeExtraTime'] as num?)?.toInt(),
      awayExtraTime: (json['awayExtraTime'] as num?)?.toInt(),
      homePenalties: (json['homePenalties'] as num?)?.toInt(),
      awayPenalties: (json['awayPenalties'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MatchScoreImplToJson(_$MatchScoreImpl instance) =>
    <String, dynamic>{
      'homeGoals': instance.homeGoals,
      'awayGoals': instance.awayGoals,
      'homeExtraTime': instance.homeExtraTime,
      'awayExtraTime': instance.awayExtraTime,
      'homePenalties': instance.homePenalties,
      'awayPenalties': instance.awayPenalties,
    };

_$MatchEventImpl _$$MatchEventImplFromJson(Map<String, dynamic> json) =>
    _$MatchEventImpl(
      type: json['type'] as String,
      playerId: json['playerId'] as String,
      playerName: json['playerName'] as String,
      minute: (json['minute'] as num?)?.toInt(),
      teamId: json['teamId'] as String?,
      detail: json['detail'] as String?,
    );

Map<String, dynamic> _$$MatchEventImplToJson(_$MatchEventImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'playerId': instance.playerId,
      'playerName': instance.playerName,
      'minute': instance.minute,
      'teamId': instance.teamId,
      'detail': instance.detail,
    };
