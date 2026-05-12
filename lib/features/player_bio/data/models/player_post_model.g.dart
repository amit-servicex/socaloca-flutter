// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostMediaSourceImpl _$$PostMediaSourceImplFromJson(
        Map<String, dynamic> json) =>
    _$PostMediaSourceImpl(
      imageUrl: json['imageUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
      thumbnail: json['thumbnail'] as String?,
      type: json['type'] as String?,
      seq: (json['seq'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PostMediaSourceImplToJson(
        _$PostMediaSourceImpl instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'videoUrl': instance.videoUrl,
      'thumbnail': instance.thumbnail,
      'type': instance.type,
      'seq': instance.seq,
    };

_$PlayerPostModelImpl _$$PlayerPostModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PlayerPostModelImpl(
      postId: json['postId'] as String?,
      title: json['title'] as String?,
      text: json['text'] as String?,
      postType: json['postType'] as String?,
      postCat: json['postCat'] as String?,
      addedOn: (json['addedOn'] as num?)?.toInt(),
      likeCount: (json['likeCount'] as num?)?.toInt(),
      commentCount: (json['commentCount'] as num?)?.toInt(),
      shareCount: (json['shareCount'] as num?)?.toInt(),
      myLike: json['myLike'] as bool?,
      sources: (json['sources'] as List<dynamic>?)
          ?.map((e) => PostMediaSource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PlayerPostModelImplToJson(
        _$PlayerPostModelImpl instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'title': instance.title,
      'text': instance.text,
      'postType': instance.postType,
      'postCat': instance.postCat,
      'addedOn': instance.addedOn,
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'shareCount': instance.shareCount,
      'myLike': instance.myLike,
      'sources': instance.sources,
    };
