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
      tournamentName: json['tournamentName'] as String?,
      roundName: json['roundName'] as String?,
      teamA: json['teamA'] as String?,
      teamAId: json['teamAId'] as String?,
      teamALogo: json['teamALogo'] as String?,
      teamAScore: json['teamAScore'] as String?,
      teamB: json['teamB'] as String?,
      teamBId: json['teamBId'] as String?,
      teamBLogo: json['teamBLogo'] as String?,
      teamBScore: json['teamBScore'] as String?,
      matchDate: json['matchDate'] as String?,
      matchTime: json['matchTime'] as String?,
      venue: json['venue'] as String?,
      ageGroup: json['ageGroup'] as String?,
      matchStatus: json['matchStatus'] as String?,
      scoreStatus: json['scoreStatus'] as String?,
      acceptStatus: json['acceptStatus'] as String?,
      asstRef1: json['asstRef1'] as String?,
      asstRef2: json['asstRef2'] as String?,
      mainRef: json['mainRef'] as String?,
      matchCommis: json['matchCommis'] as String?,
      currentMinute: json['currentMinute'] as String?,
    );

Map<String, dynamic> _$$RefereeMatchModelImplToJson(
        _$RefereeMatchModelImpl instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'tournamentId': instance.tournamentId,
      'tournamentName': instance.tournamentName,
      'roundName': instance.roundName,
      'teamA': instance.teamA,
      'teamAId': instance.teamAId,
      'teamALogo': instance.teamALogo,
      'teamAScore': instance.teamAScore,
      'teamB': instance.teamB,
      'teamBId': instance.teamBId,
      'teamBLogo': instance.teamBLogo,
      'teamBScore': instance.teamBScore,
      'matchDate': instance.matchDate,
      'matchTime': instance.matchTime,
      'venue': instance.venue,
      'ageGroup': instance.ageGroup,
      'matchStatus': instance.matchStatus,
      'scoreStatus': instance.scoreStatus,
      'acceptStatus': instance.acceptStatus,
      'asstRef1': instance.asstRef1,
      'asstRef2': instance.asstRef2,
      'mainRef': instance.mainRef,
      'matchCommis': instance.matchCommis,
      'currentMinute': instance.currentMinute,
    };

_$TournamentDropdownItemImpl _$$TournamentDropdownItemImplFromJson(
        Map<String, dynamic> json) =>
    _$TournamentDropdownItemImpl(
      tournamentId: json['tournamentId'] as String?,
      tournamentName: json['tournamentName'] as String?,
    );

Map<String, dynamic> _$$TournamentDropdownItemImplToJson(
        _$TournamentDropdownItemImpl instance) =>
    <String, dynamic>{
      'tournamentId': instance.tournamentId,
      'tournamentName': instance.tournamentName,
    };
