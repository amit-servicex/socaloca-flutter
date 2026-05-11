// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClubPlayerModelImpl _$$ClubPlayerModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ClubPlayerModelImpl(
      userId: json['userId'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      position: json['position'] as String?,
      imageUrl: json['imageUrl'] as String?,
      jersey: (json['jersey'] as num?)?.toInt() ?? 0,
      seq: (json['seq'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ClubPlayerModelImplToJson(
        _$ClubPlayerModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'position': instance.position,
      'imageUrl': instance.imageUrl,
      'jersey': instance.jersey,
      'seq': instance.seq,
    };
