// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_training_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MatchTrainingStatusModelImpl _$$MatchTrainingStatusModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MatchTrainingStatusModelImpl(
      matches: (json['matches'] as num?)?.toInt(),
      mins: (json['mins'] as num?)?.toInt(),
      goals: (json['goals'] as num?)?.toInt(),
      assists: (json['assists'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toDouble(),
      year: (json['year'] as num?)?.toInt(),
      cleanSheetCount: (json['cleanSheetCount'] as num?)?.toInt(),
      sessions: (json['sessions'] as num?)?.toInt(),
      month: (json['month'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MatchTrainingStatusModelImplToJson(
        _$MatchTrainingStatusModelImpl instance) =>
    <String, dynamic>{
      'matches': instance.matches,
      'mins': instance.mins,
      'goals': instance.goals,
      'assists': instance.assists,
      'rating': instance.rating,
      'year': instance.year,
      'cleanSheetCount': instance.cleanSheetCount,
      'sessions': instance.sessions,
      'month': instance.month,
    };
