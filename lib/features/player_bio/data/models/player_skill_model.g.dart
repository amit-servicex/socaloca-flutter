// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_skill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerSkillModelImpl _$$PlayerSkillModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PlayerSkillModelImpl(
      skillName: json['skillName'] as String?,
      skillShort: json['skillShort'] as String?,
      skillAvg: (json['skillAvg'] as num?)?.toDouble(),
      ratingCounter: (json['ratingCounter'] as num?)?.toInt(),
      rateByMe: json['rateByMe'] as bool?,
      myRating: (json['myRating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$PlayerSkillModelImplToJson(
        _$PlayerSkillModelImpl instance) =>
    <String, dynamic>{
      'skillName': instance.skillName,
      'skillShort': instance.skillShort,
      'skillAvg': instance.skillAvg,
      'ratingCounter': instance.ratingCounter,
      'rateByMe': instance.rateByMe,
      'myRating': instance.myRating,
    };
