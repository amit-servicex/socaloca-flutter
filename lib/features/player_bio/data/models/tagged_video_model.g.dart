// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tagged_video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaggedVideoAcademyModelImpl _$$TaggedVideoAcademyModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TaggedVideoAcademyModelImpl(
      academyId: json['academyId'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$TaggedVideoAcademyModelImplToJson(
        _$TaggedVideoAcademyModelImpl instance) =>
    <String, dynamic>{
      'academyId': instance.academyId,
      'name': instance.name,
    };

_$TaggedVideoModelImpl _$$TaggedVideoModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TaggedVideoModelImpl(
      postId: json['postId'] as String?,
      url: json['url'] as String?,
      thumbnail: json['thumbnail'] as String?,
      addedOn: (json['addedOn'] as num?)?.toInt(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      academy: json['academy'] == null
          ? null
          : TaggedVideoAcademyModel.fromJson(
              json['academy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TaggedVideoModelImplToJson(
        _$TaggedVideoModelImpl instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'url': instance.url,
      'thumbnail': instance.thumbnail,
      'addedOn': instance.addedOn,
      'tags': instance.tags,
      'academy': instance.academy,
    };
