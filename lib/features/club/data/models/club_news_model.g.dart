// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClubNewsModelImpl _$$ClubNewsModelImplFromJson(Map<String, dynamic> json) =>
    _$ClubNewsModelImpl(
      newsId: json['newsId'] as String,
      title: json['title'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
      videoThumb: json['videoThumb'] as String?,
      videoId: json['videoId'] as String?,
      link: json['link'] as String?,
      newsDate: json['newsDate'] as String?,
      newsDateGmt: (json['newsDateGmt'] as num?)?.toInt() ?? 0,
      newsCat: json['newsCat'] as String?,
    );

Map<String, dynamic> _$$ClubNewsModelImplToJson(_$ClubNewsModelImpl instance) =>
    <String, dynamic>{
      'newsId': instance.newsId,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'videoUrl': instance.videoUrl,
      'videoThumb': instance.videoThumb,
      'videoId': instance.videoId,
      'link': instance.link,
      'newsDate': instance.newsDate,
      'newsDateGmt': instance.newsDateGmt,
      'newsCat': instance.newsCat,
    };
