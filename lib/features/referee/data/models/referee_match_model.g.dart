// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referee_match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RefereeMatchModelImpl _$$RefereeMatchModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RefereeMatchModelImpl(
      matchId: json['matchId'] as String?,
      tournamentId: json['tournamentId'] as String?,
      tournamentName: json['tournament'] as String?,
      roundName: json['roundName'] as String?,
      city: json['city'] as String?,
      fieldName: json['fieldName'] as String?,
      mainAccept: (json['mainAccept'] as num?)?.toInt(),
      matchDateTimeGmt: (json['matchDateTimeGmt'] as num?)?.toInt(),
      myTeamId: json['myTeamId'] as String?,
      opponentTeamId: json['opponentTeamId'] as String?,
      stadiumName: json['stadiumName'] as String?,
      score: json['score'] == null
          ? null
          : RefereeScoreModel.fromJson(json['score'] as Map<String, dynamic>),
      teams: (json['teams'] as List<dynamic>?)
          ?.map((e) => RefereeTeamModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      ageGroup: json['ageGroup'] as String?,
      matchStatus: json['matchStatus'] as String?,
      scoreStatus: json['scoreStatus'] as String?,
      acceptStatus: json['acceptStatus'] as String?,
      asstRef1: json['asstRef1'] as String?,
      asstRef2: json['asstRef2'] as String?,
      mainRef: json['mainRef'] as String?,
      matchCommis: json['matchCommis'] as String?,
      currentMinute: json['currentMinute'] as String?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$$RefereeMatchModelImplToJson(
        _$RefereeMatchModelImpl instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'tournamentId': instance.tournamentId,
      'tournament': instance.tournamentName,
      'roundName': instance.roundName,
      'city': instance.city,
      'fieldName': instance.fieldName,
      'mainAccept': instance.mainAccept,
      'matchDateTimeGmt': instance.matchDateTimeGmt,
      'myTeamId': instance.myTeamId,
      'opponentTeamId': instance.opponentTeamId,
      'stadiumName': instance.stadiumName,
      'score': instance.score,
      'teams': instance.teams,
      'ageGroup': instance.ageGroup,
      'matchStatus': instance.matchStatus,
      'scoreStatus': instance.scoreStatus,
      'acceptStatus': instance.acceptStatus,
      'asstRef1': instance.asstRef1,
      'asstRef2': instance.asstRef2,
      'mainRef': instance.mainRef,
      'matchCommis': instance.matchCommis,
      'currentMinute': instance.currentMinute,
      'state': instance.state,
    };

_$RefereeScoreModelImpl _$$RefereeScoreModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RefereeScoreModelImpl(
      myGoals: (json['myGoals'] as num?)?.toInt(),
      opponentGoals: (json['opponentGoals'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$RefereeScoreModelImplToJson(
        _$RefereeScoreModelImpl instance) =>
    <String, dynamic>{
      'myGoals': instance.myGoals,
      'opponentGoals': instance.opponentGoals,
    };

_$RefereeTeamModelImpl _$$RefereeTeamModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RefereeTeamModelImpl(
      teamId: json['teamId'] as String?,
      teamName: json['teamName'] as String?,
      teamShortName: json['teamShortName'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$RefereeTeamModelImplToJson(
        _$RefereeTeamModelImpl instance) =>
    <String, dynamic>{
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'teamShortName': instance.teamShortName,
      'imageUrl': instance.imageUrl,
    };

_$TournamentDropdownItemImpl _$$TournamentDropdownItemImplFromJson(
        Map<String, dynamic> json) =>
    _$TournamentDropdownItemImpl(
      tournamentId: json['tournamentId'] as String?,
      tournamentName: json['name'] as String?,
    );

Map<String, dynamic> _$$TournamentDropdownItemImplToJson(
        _$TournamentDropdownItemImpl instance) =>
    <String, dynamic>{
      'tournamentId': instance.tournamentId,
      'name': instance.tournamentName,
    };
