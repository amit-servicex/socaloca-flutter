// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_skill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerSkillModelImpl _$$PlayerSkillModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PlayerSkillModelImpl(
      skillName: json['skillName'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$PlayerSkillModelImplToJson(
        _$PlayerSkillModelImpl instance) =>
    <String, dynamic>{
      'skillName': instance.skillName,
      'rating': instance.rating,
    };
