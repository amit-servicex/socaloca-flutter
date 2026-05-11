// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostMediaSourceImpl _$$PostMediaSourceImplFromJson(
        Map<String, dynamic> json) =>
    _$PostMediaSourceImpl(
      url: json['url'] as String?,
      type: json['type'] as String?,
      thumbnail: json['thumbnail'] as String?,
    );

Map<String, dynamic> _$$PostMediaSourceImplToJson(
        _$PostMediaSourceImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'type': instance.type,
      'thumbnail': instance.thumbnail,
    };

_$PlayerPostModelImpl _$$PlayerPostModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PlayerPostModelImpl(
      postId: json['postId'] as String?,
      text: json['text'] as String?,
      addedOn: (json['addedOn'] as num?)?.toInt(),
      likeCount: (json['likeCount'] as num?)?.toInt(),
      commentCount: (json['commentCount'] as num?)?.toInt(),
      shareCount: (json['shareCount'] as num?)?.toInt(),
      sources: (json['sources'] as List<dynamic>?)
          ?.map((e) => PostMediaSource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PlayerPostModelImplToJson(
        _$PlayerPostModelImpl instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'text': instance.text,
      'addedOn': instance.addedOn,
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'shareCount': instance.shareCount,
      'sources': instance.sources,
    };
