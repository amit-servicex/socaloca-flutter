// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationModelImpl(
      id: json['_id'] as String,
      forUserId: json['forUserId'] as String,
      notificationType: json['notificationType'] as String,
      imageUrl: json['imageUrl'] as String?,
      title: json['title'] as String,
      body: json['body'] as String,
      payload: json['payload'] as Map<String, dynamic>,
      seen: json['seen'] as bool,
      generatedOn: (json['generatedOn'] as num).toInt(),
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'forUserId': instance.forUserId,
      'notificationType': instance.notificationType,
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'body': instance.body,
      'payload': instance.payload,
      'seen': instance.seen,
      'generatedOn': instance.generatedOn,
    };
