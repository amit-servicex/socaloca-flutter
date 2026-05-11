// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerTeamModelImpl _$$PlayerTeamModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PlayerTeamModelImpl(
      teamId: json['teamId'] as String?,
      teamName: json['teamName'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$PlayerTeamModelImplToJson(
        _$PlayerTeamModelImpl instance) =>
    <String, dynamic>{
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'imageUrl': instance.imageUrl,
    };
