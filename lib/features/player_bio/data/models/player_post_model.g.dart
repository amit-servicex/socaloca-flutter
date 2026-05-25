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
      size: (json['size'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PostMediaSourceImplToJson(
        _$PostMediaSourceImpl instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'videoUrl': instance.videoUrl,
      'thumbnail': instance.thumbnail,
      'type': instance.type,
      'seq': instance.seq,
      'size': instance.size,
    };

_$PlayerPostModelImpl _$$PlayerPostModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PlayerPostModelImpl(
      postId: json['postId'] as String?,
      title: json['title'] as String?,
      text: json['text'] as String?,
      postType: json['postType'] as String?,
      postCat: json['postCat'],
      addedBy: json['addedBy'] as String?,
      addedOn: (json['addedOn'] as num?)?.toInt(),
      likeCount: (json['likeCount'] as num?)?.toInt(),
      commentCount: (json['commentCount'] as num?)?.toInt(),
      shareCount: (json['shareCount'] as num?)?.toInt(),
      reportCount: (json['reportCount'] as num?)?.toInt(),
      myLike: json['myLike'] as bool?,
      sources: (json['sources'] as List<dynamic>?)
          ?.map((e) => PostMediaSource.fromJson(e as Map<String, dynamic>))
          .toList(),
      size: (json['size'] as num?)?.toInt(),
      postNotify: json['postNotify'] as bool?,
      tagged: json['tagged'] as List<dynamic>?,
      isDelete: json['isDelete'] as bool?,
      comments: json['comments'] as List<dynamic>?,
    );

Map<String, dynamic> _$$PlayerPostModelImplToJson(
        _$PlayerPostModelImpl instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'title': instance.title,
      'text': instance.text,
      'postType': instance.postType,
      'postCat': instance.postCat,
      'addedBy': instance.addedBy,
      'addedOn': instance.addedOn,
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'shareCount': instance.shareCount,
      'reportCount': instance.reportCount,
      'myLike': instance.myLike,
      'sources': instance.sources,
      'size': instance.size,
      'postNotify': instance.postNotify,
      'tagged': instance.tagged,
      'isDelete': instance.isDelete,
      'comments': instance.comments,
    };
