// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'endorsement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EndorserUserModelImpl _$$EndorserUserModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EndorserUserModelImpl(
      userId: json['userId'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isPlayer: json['isPlayer'] as bool?,
      isCoach: json['isCoach'] as bool?,
      isAdmin: json['isAdmin'] as bool?,
      isFan: json['isFan'] as bool?,
    );

Map<String, dynamic> _$$EndorserUserModelImplToJson(
        _$EndorserUserModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'imageUrl': instance.imageUrl,
      'isPlayer': instance.isPlayer,
      'isCoach': instance.isCoach,
      'isAdmin': instance.isAdmin,
      'isFan': instance.isFan,
    };

_$EndorsementAcademyModelImpl _$$EndorsementAcademyModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EndorsementAcademyModelImpl(
      academyId: json['academyId'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$EndorsementAcademyModelImplToJson(
        _$EndorsementAcademyModelImpl instance) =>
    <String, dynamic>{
      'academyId': instance.academyId,
      'name': instance.name,
    };

_$EndorsementModelImpl _$$EndorsementModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EndorsementModelImpl(
      comment: json['comment'] as String?,
      addedOn: (json['addedOn'] as num?)?.toInt(),
      published: (json['published'] as num?)?.toInt(),
      userDetails: json['userDetails'] == null
          ? null
          : EndorserUserModel.fromJson(
              json['userDetails'] as Map<String, dynamic>),
      academy: json['academy'] == null
          ? null
          : EndorsementAcademyModel.fromJson(
              json['academy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$EndorsementModelImplToJson(
        _$EndorsementModelImpl instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'addedOn': instance.addedOn,
      'published': instance.published,
      'userDetails': instance.userDetails,
      'academy': instance.academy,
    };
