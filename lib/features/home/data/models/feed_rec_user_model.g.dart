// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_rec_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedRecUserModelImpl _$$FeedRecUserModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FeedRecUserModelImpl(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      userType: json['userType'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      isFollowing: json['isFollowing'] as bool? ?? false,
      followCount: (json['followCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$FeedRecUserModelImplToJson(
        _$FeedRecUserModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'imageUrl': instance.imageUrl,
      'userType': instance.userType,
      'country': instance.country,
      'city': instance.city,
      'isFollowing': instance.isFollowing,
      'followCount': instance.followCount,
    };
