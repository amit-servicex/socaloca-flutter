// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamModelImpl _$$TeamModelImplFromJson(Map<String, dynamic> json) =>
    _$TeamModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      logo: json['logo'] as String?,
      coverImage: json['coverImage'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      adminId: json['adminId'] as String?,
      adminName: json['adminName'] as String?,
      bio: json['bio'] as String?,
      playersCount: (json['playersCount'] as num?)?.toInt() ?? 0,
      matchesCount: (json['matchesCount'] as num?)?.toInt() ?? 0,
      isFollowing: json['isFollowing'] as bool? ?? false,
      formationDefault: json['formationDefault'] as String?,
    );

Map<String, dynamic> _$$TeamModelImplToJson(_$TeamModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'coverImage': instance.coverImage,
      'country': instance.country,
      'city': instance.city,
      'adminId': instance.adminId,
      'adminName': instance.adminName,
      'bio': instance.bio,
      'playersCount': instance.playersCount,
      'matchesCount': instance.matchesCount,
      'isFollowing': instance.isFollowing,
      'formationDefault': instance.formationDefault,
    };

_$TeamPlayerImpl _$$TeamPlayerImplFromJson(Map<String, dynamic> json) =>
    _$TeamPlayerImpl(
      userId: json['userId'] as String,
      name: json['name'] as String,
      profileImage: json['profileImage'] as String?,
      position: json['position'] as String?,
      jerseyNumber: (json['jerseyNumber'] as num?)?.toInt(),
      role: json['role'] as String?,
      isAdmin: json['isAdmin'] as bool? ?? false,
    );

Map<String, dynamic> _$$TeamPlayerImplToJson(_$TeamPlayerImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'profileImage': instance.profileImage,
      'position': instance.position,
      'jerseyNumber': instance.jerseyNumber,
      'role': instance.role,
      'isAdmin': instance.isAdmin,
    };
