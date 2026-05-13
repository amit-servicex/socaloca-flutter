// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_player_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClubPlayerStatsModelImpl _$$ClubPlayerStatsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ClubPlayerStatsModelImpl(
      matchCount: (json['matchCount'] as num?)?.toInt() ?? 0,
      goalCount: (json['goalCount'] as num?)?.toInt() ?? 0,
      assistCount: (json['assistCount'] as num?)?.toInt() ?? 0,
      yellowCardCount: (json['yellowCardCount'] as num?)?.toInt() ?? 0,
      redCardCount: (json['redCardCount'] as num?)?.toInt() ?? 0,
      mvpCount: (json['mvpCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ClubPlayerStatsModelImplToJson(
        _$ClubPlayerStatsModelImpl instance) =>
    <String, dynamic>{
      'matchCount': instance.matchCount,
      'goalCount': instance.goalCount,
      'assistCount': instance.assistCount,
      'yellowCardCount': instance.yellowCardCount,
      'redCardCount': instance.redCardCount,
      'mvpCount': instance.mvpCount,
    };
