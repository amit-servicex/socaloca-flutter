// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TournamentModelImpl _$$TournamentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TournamentModelImpl(
      tmntId: json['tournamentId'] as String?,
      tmntName: json['name'] as String?,
      imageUrl: json['logo'] as String?,
      status: json['status'] as String?,
      tmntType: json['tmntType'] as String?,
    );

Map<String, dynamic> _$$TournamentModelImplToJson(
        _$TournamentModelImpl instance) =>
    <String, dynamic>{
      'tournamentId': instance.tmntId,
      'name': instance.tmntName,
      'logo': instance.imageUrl,
      'status': instance.status,
      'tmntType': instance.tmntType,
    };
