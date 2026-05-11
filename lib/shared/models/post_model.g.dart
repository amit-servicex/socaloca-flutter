// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostModelImpl _$$PostModelImplFromJson(Map<String, dynamic> json) =>
    _$PostModelImpl(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      authorImage: json['authorImage'] as String?,
      authorType: json['authorType'] as String?,
      text: json['text'] as String?,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      videoUrl: json['videoUrl'] as String?,
      videoThumb: json['videoThumb'] as String?,
      likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
      commentsCount: (json['commentsCount'] as num?)?.toInt() ?? 0,
      isLiked: json['isLiked'] as bool? ?? false,
      isBlocked: json['isBlocked'] as bool? ?? false,
      createdAt: json['createdAt'] as String?,
      postType: json['postType'] as String?,
      language: json['language'] as String?,
      translatedText: json['translatedText'] as String?,
    );

Map<String, dynamic> _$$PostModelImplToJson(_$PostModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'authorImage': instance.authorImage,
      'authorType': instance.authorType,
      'text': instance.text,
      'images': instance.images,
      'videoUrl': instance.videoUrl,
      'videoThumb': instance.videoThumb,
      'likesCount': instance.likesCount,
      'commentsCount': instance.commentsCount,
      'isLiked': instance.isLiked,
      'isBlocked': instance.isBlocked,
      'createdAt': instance.createdAt,
      'postType': instance.postType,
      'language': instance.language,
      'translatedText': instance.translatedText,
    };

_$CommentModelImpl _$$CommentModelImplFromJson(Map<String, dynamic> json) =>
    _$CommentModelImpl(
      id: json['id'] as String,
      postId: json['postId'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      authorImage: json['authorImage'] as String?,
      text: json['text'] as String,
      likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
      isLiked: json['isLiked'] as bool? ?? false,
      repliesCount: (json['repliesCount'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] as String?,
      replies: (json['replies'] as List<dynamic>?)
              ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CommentModelImplToJson(_$CommentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'authorImage': instance.authorImage,
      'text': instance.text,
      'likesCount': instance.likesCount,
      'isLiked': instance.isLiked,
      'repliesCount': instance.repliesCount,
      'createdAt': instance.createdAt,
      'replies': instance.replies,
    };
