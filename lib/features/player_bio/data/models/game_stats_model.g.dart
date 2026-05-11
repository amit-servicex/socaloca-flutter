// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameStatsModelImpl _$$GameStatsModelImplFromJson(Map<String, dynamic> json) =>
    _$GameStatsModelImpl(
      matchCount: (json['matchCount'] as num?)?.toInt() ?? 0,
      goalCount: (json['goalCount'] as num?)?.toInt() ?? 0,
      assistCount: (json['assistCount'] as num?)?.toInt() ?? 0,
      yellowCardCount: (json['yellowCardCount'] as num?)?.toInt() ?? 0,
      redCardCount: (json['redCardCount'] as num?)?.toInt() ?? 0,
      mvpCount: (json['mvpCount'] as num?)?.toInt() ?? 0,
      cleanSheetCount: (json['cleanSheetCount'] as num?)?.toInt() ?? 0,
      gameType: json['gameType'] as String?,
      year: (json['year'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$GameStatsModelImplToJson(
        _$GameStatsModelImpl instance) =>
    <String, dynamic>{
      'matchCount': instance.matchCount,
      'goalCount': instance.goalCount,
      'assistCount': instance.assistCount,
      'yellowCardCount': instance.yellowCardCount,
      'redCardCount': instance.redCardCount,
      'mvpCount': instance.mvpCount,
      'cleanSheetCount': instance.cleanSheetCount,
      'gameType': instance.gameType,
      'year': instance.year,
    };
