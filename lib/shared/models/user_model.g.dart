// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String?,
      username: json['username'] as String?,
      profileImage: json['profileImage'] as String?,
      coverImage: json['coverImage'] as String?,
      userType: json['userType'] as String?,
      bio: json['bio'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      phone: json['phone'] as String?,
      dob: json['dob'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
      isPrivate: json['isPrivate'] as bool? ?? false,
      isBlocked: json['isBlocked'] as bool? ?? false,
      policyAccepted: json['policyAccepted'] as bool? ?? false,
      profile: json['profile'] as bool? ?? false,
      isPlayer: json['isPlayer'] as bool? ?? false,
      isCoach: json['isCoach'] as bool? ?? false,
      isAdmin: json['isAdmin'] as bool? ?? false,
      isFan: json['isFan'] as bool? ?? false,
      isReferee: json['isReferee'] as bool? ?? false,
      followersCount: (json['followersCount'] as num?)?.toInt(),
      followingCount: (json['followingCount'] as num?)?.toInt(),
      matchesCount: (json['matchesCount'] as num?)?.toInt(),
      preferredPosition: json['preferredPosition'] as String?,
      nationality: json['nationality'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'username': instance.username,
      'profileImage': instance.profileImage,
      'coverImage': instance.coverImage,
      'userType': instance.userType,
      'bio': instance.bio,
      'country': instance.country,
      'city': instance.city,
      'phone': instance.phone,
      'dob': instance.dob,
      'isVerified': instance.isVerified,
      'isPrivate': instance.isPrivate,
      'isBlocked': instance.isBlocked,
      'policyAccepted': instance.policyAccepted,
      'profile': instance.profile,
      'isPlayer': instance.isPlayer,
      'isCoach': instance.isCoach,
      'isAdmin': instance.isAdmin,
      'isFan': instance.isFan,
      'isReferee': instance.isReferee,
      'followersCount': instance.followersCount,
      'followingCount': instance.followingCount,
      'matchesCount': instance.matchesCount,
      'preferredPosition': instance.preferredPosition,
      'nationality': instance.nationality,
      'token': instance.token,
    };

_$ClubUserModelImpl _$$ClubUserModelImplFromJson(Map<String, dynamic> json) =>
    _$ClubUserModelImpl(
      id: json['id'] as String,
      clubName: json['clubName'] as String,
      email: json['email'] as String,
      logo: json['logo'] as String?,
      coverImage: json['coverImage'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      bio: json['bio'] as String?,
      phone: json['phone'] as String?,
      token: json['token'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
      followersCount: (json['followersCount'] as num?)?.toInt(),
      subscriptionPlan: json['subscriptionPlan'] as String?,
    );

Map<String, dynamic> _$$ClubUserModelImplToJson(_$ClubUserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clubName': instance.clubName,
      'email': instance.email,
      'logo': instance.logo,
      'coverImage': instance.coverImage,
      'country': instance.country,
      'city': instance.city,
      'bio': instance.bio,
      'phone': instance.phone,
      'token': instance.token,
      'isVerified': instance.isVerified,
      'followersCount': instance.followersCount,
      'subscriptionPlan': instance.subscriptionPlan,
    };
