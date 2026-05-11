// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerModelImpl _$$PlayerModelImplFromJson(Map<String, dynamic> json) =>
    _$PlayerModelImpl(
      userId: json['userId'] as String,
      playerId: json['playerId'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      playPosition: json['playPosition'] as String?,
      playPositionType: json['playPositionType'] as String?,
      teamJerseyNo: json['teamJerseyNo'] as String?,
      yearOfBirth: json['yearOfBirth'] as String?,
      dob: json['dob'] as String?,
      nationality: json['nationality'] as String?,
      isPlayer: json['isPlayer'] as bool? ?? false,
      isCoach: json['isCoach'] as bool? ?? false,
      isAdmin: json['isAdmin'] as bool? ?? false,
      goalCount: (json['goalCount'] as num?)?.toInt() ?? 0,
      assistCount: (json['assistCount'] as num?)?.toInt() ?? 0,
      momCount: (json['momCount'] as num?)?.toInt() ?? 0,
      rCard: (json['rCard'] as num?)?.toInt() ?? 0,
      yCard: (json['yCard'] as num?)?.toInt() ?? 0,
      lastOnline: (json['lastOnline'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PlayerModelImplToJson(_$PlayerModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'playerId': instance.playerId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'imageUrl': instance.imageUrl,
      'playPosition': instance.playPosition,
      'playPositionType': instance.playPositionType,
      'teamJerseyNo': instance.teamJerseyNo,
      'yearOfBirth': instance.yearOfBirth,
      'dob': instance.dob,
      'nationality': instance.nationality,
      'isPlayer': instance.isPlayer,
      'isCoach': instance.isCoach,
      'isAdmin': instance.isAdmin,
      'goalCount': instance.goalCount,
      'assistCount': instance.assistCount,
      'momCount': instance.momCount,
      'rCard': instance.rCard,
      'yCard': instance.yCard,
      'lastOnline': instance.lastOnline,
    };
