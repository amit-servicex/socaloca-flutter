// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'endorsed_player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EndorsedPlayerModelImpl _$$EndorsedPlayerModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EndorsedPlayerModelImpl(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      position: json['position'] as String?,
      endorsementCount: (json['endorsementCount'] as num?)?.toInt() ?? 0,
      country: json['country'] as String?,
      city: json['city'] as String?,
      userType: json['userType'] as String?,
    );

Map<String, dynamic> _$$EndorsedPlayerModelImplToJson(
        _$EndorsedPlayerModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'imageUrl': instance.imageUrl,
      'position': instance.position,
      'endorsementCount': instance.endorsementCount,
      'country': instance.country,
      'city': instance.city,
      'userType': instance.userType,
    };
