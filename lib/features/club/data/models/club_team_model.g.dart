// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClubTeamModelImpl _$$ClubTeamModelImplFromJson(Map<String, dynamic> json) =>
    _$ClubTeamModelImpl(
      teamId: json['teamId'] as String,
      teamName: json['teamName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      seq: (json['seq'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ClubTeamModelImplToJson(_$ClubTeamModelImpl instance) =>
    <String, dynamic>{
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'imageUrl': instance.imageUrl,
      'seq': instance.seq,
    };
