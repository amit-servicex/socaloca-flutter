// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchUserModelImpl _$$SearchUserModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SearchUserModelImpl(
      userId: json['userId'] as String,
      id: json['_id'] as String?,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      profileName: json['profileName'] as String?,
      profileImage: json['imageUrl'] as String?,
      country: json['country'] as String?,
      playPosition: json['playPosition'] as String?,
      isPlayer: json['isPlayer'] as bool? ?? false,
      isCoach: json['isCoach'] as bool? ?? false,
      isAdmin: json['isAdmin'] as bool? ?? false,
      isReferee: json['isReferee'] as bool? ?? false,
      isFan: json['isFan'] as bool? ?? false,
      appearance: (json['appearance'] as num?)?.toInt() ?? 0,
      goals: (json['goals'] as num?)?.toInt() ?? 0,
      postCount: (json['postCount'] as num?)?.toInt() ?? 0,
      endorsedBy: (json['endorsedBy'] as num?)?.toInt() ?? 0,
      followers: (json['followers'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$SearchUserModelImplToJson(
        _$SearchUserModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'profileName': instance.profileName,
      'imageUrl': instance.profileImage,
      'country': instance.country,
      'playPosition': instance.playPosition,
      'isPlayer': instance.isPlayer,
      'isCoach': instance.isCoach,
      'isAdmin': instance.isAdmin,
      'isReferee': instance.isReferee,
      'isFan': instance.isFan,
      'appearance': instance.appearance,
      'goals': instance.goals,
      'postCount': instance.postCount,
      'endorsedBy': instance.endorsedBy,
      'followers': instance.followers,
    };
