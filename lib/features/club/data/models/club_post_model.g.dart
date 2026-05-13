// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClubPostModelImpl _$$ClubPostModelImplFromJson(Map<String, dynamic> json) =>
    _$ClubPostModelImpl(
      postId: json['postId'] as String?,
      imageUrl: json['imageUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
      postCaption: json['postCaption'] as String?,
      timestamp: (json['timestamp'] as num?)?.toInt(),
      likeCount: (json['likeCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ClubPostModelImplToJson(_$ClubPostModelImpl instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'imageUrl': instance.imageUrl,
      'videoUrl': instance.videoUrl,
      'postCaption': instance.postCaption,
      'timestamp': instance.timestamp,
      'likeCount': instance.likeCount,
    };
